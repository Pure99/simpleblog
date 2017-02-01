	class Comment < ApplicationRecord
		belongs_to :post

		def self.interpol (x)
			if 0<x&&x<6 then z=1.07 
			elsif 6<=x&&x<8 then z=(0.01*x+1.01).round(2) 
			elsif 8<=x&&x<9 then z=(0.02*x+0.93).round(2) 
			elsif 9<=x&&x<10 then z=(0.03*x+0.84).round(2) 
			elsif 10<=x&&x<11 then z=(0.04*x+0.74).round(2) 
			elsif 11<=x&&x<=16 then  z=(0.05*x+0.63).round(2) 
			else z=0 
			end
			return z
		end

		def self.alfa (a)
			if a==2 then alfa=1.13 
			elsif a==3 then alfa=1.69 
			elsif a==4 then alfa=2.06 
			elsif a==5 then alfa=2.33 
			elsif a==6 then alfa=2.5 
			else alfa=1;
			end
			return alfa
		end

		def sum_p (a)
			if a.class == Array  && a != '[]'
				sum=0
				sumR=0
          a.each { |x| sum = sum + x } #сумма всех элементов массива
          a.each { |x| sumR = sumR + (x-sum/a.size)**2 } # сумма квадратов разностей 
          if a.size > 6 
            s_m = Math.sqrt(sumR/(a.size-1)) # среднее кввадратическое отклонение
        elsif a.size <= 6 
        	s_m = ((a.max-a.min)/alfa(a.size))
        else 
        	return 
        end
          s_v = (s_m*100/(sum/a.size)).round(1) # коэффициент вариации
          k_t = interpol s_v #коэффициент требуемой прочности 
          return sum.round(1), a.max, a.min, a.size, (sum/a.size).round(1), sumR.round(1), a.max-a.min, s_m.round(1), s_v, k_t
      end
      return 
  end


  def self.sumP a
  	Comment.where(:post_id => a).sum('pr_28_mpa')
  end 

  def self.midS a
  	if Comment.where(:post_id => a).count('pr_28_mpa') != 0
  		(sumP(a)/Comment.where(:post_id => a).count('pr_28_mpa')).round(1)
  	else 
  		return 0
  	end
  end 

  def self.r_r a

    Comment.where(:post_id => a).pr_28_mpa.to_f-midS(a)
  end

  def self.sumR a
  	sumR=0
  	Comment.where(:post_id => a).each { |x| sumR = sumR + ((x.pr_28_mpa.to_f-midS(a))**2).round(1) }
  	return sumR
  end 

  def self.max_min a
  	if Comment.where(:post_id => a).maximum('pr_28_mpa') && Comment.where(:post_id => a).minimum('pr_28_mpa') 
  		Comment.where(:post_id => a).maximum('pr_28_mpa')-Comment.where(:post_id => a).minimum('pr_28_mpa')
  	else
  		return 0
  	end
  end 

  def self.s_m a
  	if Comment.where(:post_id => a).count('pr_28_mpa') > 6
  		s_m = Math.sqrt(sumR(a)/(Comment.where(:post_id => a).count('pr_28_mpa')-1)) 
  	elsif Comment.where(:post_id => a).count('pr_28_mpa') <= 6
  		s_m = max_min(a)/alfa(Comment.where(:post_id => a).count('pr_28_mpa'))
  	end
  	return s_m.round(1)
  end 

  def self.v_m a
  	v_m = (s_m(a)*100/midS(a)).round(1)
  end 

  def self.k_t a
   	k_t = interpol(v_m(a)) #коэффициент требуемой прочности 
   end 

  def self.r_t (a,str)
   	pat = /(B|В)(3,5|3.5|5|7,5|7.5|10|12,5|12.5|15|20|22,5|22.5|25|30|35|40|45|50|55|60)/
   	m = pat.match(str)
   	unless m
   		r_t = 'Класс?'
   	else 
   		r_t = (k_t(a)*m[2].to_f).round(1)
  	end
   	#/(B|В)(15|22,5|25)/.match('Сводная По составу №1 В25F100hjc25hgkhgkgl25')[2]
   
  end 



end
