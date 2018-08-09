# def isbn_10(num)
#     num.gsub!(/[- ]/, '')
#     bad = 0
#     if num.gsub(/[\D]/, '') != num
#         bad += 1
#     end
#     if num.end_with?('x') || num.end_with?('X')
#         bad -= 1
#         check = num.gsub(/[\D]/, '')
#         x = num[-1]
#         if "#{check}#{x}" != num
#             bad += 1
#         end
#     end
     
#     unless bad <= 0
#         return false
#     end

#     temp = num.split('')
#     check_digit = temp.pop

#     if check_digit == 'x' || check_digit == 'X'
#         check_digit = 10
#     end

#     sum = 0

#     temp.each_with_index do |v,i|
#         holder = v.to_i * (i + 1)
#         sum += holder
#     end

#     checksum = sum % 11

#     if checksum == check_digit.to_i
#         return true
#     else
#         return false
#     end
# end

# def isbn_13(num)
#     num.gsub!(/[- ]/, '')
#     if num.gsub(/[\D]/, '') != num
#         return false
#     end

#     temp = num.split('')
#     check_digit = temp.pop

#     sum = 0
#     count = 0

#     temp.each do |v|
#         if count % 2 == 0
#             alt = 1
#         else
#             alt = 3
#         end
#         holder = v.to_i * alt
#         sum += holder
#         count += 1
#     end
    
#     checksum = 10 - (sum % 10)
#     if checksum.to_s.length > 1
#         checksum %= 10
#     end

#     if checksum == check_digit.to_i
#         return true
#     else
#         return false
#     end
# end

# def isbn(num)
#     num.gsub!(/[- ]/, '')
#     if num.length == 10
#         return isbn_10(num)
#     elsif num.length == 13
#         return isbn_13(num)
#     else
#         return false
#     end
# end

#Refactoring below

def isbn_refa1(num)
    num.gsub!(/[- ]/, ''); bad = 0
    if num.gsub(/[\D]/, '') != num
        bad += 1
    end
    if num.end_with?('x') || num.end_with?('X')
        bad -= 1; check = num.gsub(/[\D]/, ''); x = num[-1]
        if "#{check}#{x}" != num
            bad += 1
        end
    end
    if num.length < 10
        bad += 1
    end
    unless bad <= 0
        return false
    else; num
    end
end

def isbn_refa2(num)
    num = isbn_refa1(num)
    if num == false; return false; end
    temp = num.split(''); check_digit = temp.pop
    if check_digit == 'x' || check_digit == 'X'
        check_digit = 10
    end
    sum = 0; count = 0
    temp.each_with_index do |v,i|
        if count % 2 == 0; alt = 1
        else; alt = 3
        end
        if num.length == 10; holder = v.to_i * (i + 1)
        else; holder = v.to_i * alt
        end
        sum += holder; count += 1
    end
    temp_arr = [num, sum, check_digit]
end

def isbn_refa3(num)
    arr = isbn_refa2(num)
    if arr == false; return false; end
    num = arr[0]; sum = arr[1]; check_digit = arr[2]
    if num.length == 10
        if sum % 11 == check_digit.to_i
            return true; else; return false
        end
    else; checksum = 10 - sum % 10
        if checksum.to_s.length > 1
            checksum = (10 - sum % 10) % 10
        end
        if checksum == check_digit.to_i
            return true; else; return false
        end
    end 
end