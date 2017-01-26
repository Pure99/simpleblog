class Comment < ApplicationRecord
  belongs_to :post


def interpol (x)
    if 0<x&&x<6 then z=1.07 
    elsif 6<=x&&x<8 then z=(0.01*x+1.01).round(2) 
    elsif 8<=x&&x<9 then z=(0.02*x+0.93).round(2) 
    elsif 9<=x&&x<10 then z=(0.03*x+0.84).round(2) 
    elsif 10<=x&&x<11 then z=(0.04*x+0.74).round(2) 
    elsif 11<=x&&x<=16 then  z=(0.05*x+0.63).round(2) 
    else z='overload' 
    end
    return z
end

def alfa (a)
    if a==2 then alfa=1.13 
    elsif a==3 then alfa=1.69 
    elsif a==4 then alfa=2.06 
    elsif a==5 then alfa=2.33 
    elsif a==6 then alfa=2.5 
    else alfa=1;
    end
    return alfa
end
#puts self.alfa 7
def sum_p (a)
    if a.class == Array
       sum=0.0
       sumR=0
       a.each { |x| sum = sum + x } #сумма всех элементов массива
       a.each { |x| sumR = sumR + (x-sum/a.size)**2 } # сумма квадратов разностей 
   		if a.size > 6 
   			s_m = Math.sqrt(sumR/(a.size-1)) # среднее кввадратическое отклонение
		else
			s_m = ((a.max-a.min)/alfa(a.size))
		end
		s_v = (s_m*100/(sum/a.size)).round(1) # коэффициент вариации
   		k_t = interpol s_v #коэффициент требуемой прочности 
		return sum.round(1), a.max, a.min, a.size, (sum/a.size).round(1), sumR.round(1), a.max-a.min, s_m.round(1), s_v, k_t
 	end
puts 'not array'
end

  
end
