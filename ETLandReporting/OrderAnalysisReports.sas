libname target '/azuredm/OrionETLTarget/';
data work.orderanalysis;
set target.orderanalysis;
revenue=total_retail_price-(quantity*costprice_per_unit);
format revenue dollar12.;
run;
proc format;
value ordertype 1='In Store Purchases'
                    2='Orion Online E-Commerce Orders'
                    3='Partner Online E-Commerce Orders';
run;
proc tabulate data=work.orderanalysis  ;
class Order_Type Customer_Group Country;
var revenue;
format order_type ordertype.;
table country=' '*revenue=' '*sum=' ', order_type='Total Revenue'*customer_group=' '/ box='supplier country' row=float;
run;
