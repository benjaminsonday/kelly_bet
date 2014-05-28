drift   = 0.08 / 10
std_dev = 0.22 / Math.sqrt(10)
num_sim = 10000
num_yrs = 40 * 10
int_rat = 0.0
leverage_range = [0.1, 7.0]
leverage_pnts  = 30

def randn
  theta = 2 * Math::PI * rand
  rho = Math.sqrt(-2 * Math.log(1 - rand))
  x = rho * Math.cos(theta)
  return x
end

lev_pts = []
mny_pts = []
leverage_pnts.times.each do |lev_idx|
  this_leverage = leverage_range[0] +
      lev_idx * (leverage_range[1] - leverage_range[0]) / (leverage_pnts - 1)
  total_money = 0.0
  num_sim.times.each do |sim_idx|
    current_money = 1.0
    num_yrs.times.each do |yr_idx|
      money_made_market = current_money * this_leverage * (drift + std_dev * randn)
      money_made_interest = (1 - this_leverage) * current_money * int_rat
      current_money += (money_made_market + money_made_interest)
      current_money = 0 if current_money <= 0 # margin call
    end
    total_money += current_money
  end
  lev_pts << this_leverage
  mny_pts << (total_money / num_sim)
end

# Brennan  5 Chicken Fingers with 1 Side - side = kale
# Spencer Half Rotisserie Chicken with 2 Sides (beans + kale)
# Alexander 5 chicken fingers with 1 side: mac n cheese + small chopped salad
# Ilya  Half Rotisserie Chicken with 2 Sides (beans + kale)
# Casey Quarter white meat rotisserie chicken w 1 side: kale
# Matt  C$  Quarter Dark Meat Rotisserie with 1 Side (Kale) + Roasted Potatoes
# Matt I. Half Rotisserie Chicken with 2 Sides (potatoes and gravy + kale)
