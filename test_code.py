def calculate_total(items):
    total = 0
    for item in items:
        total = total + item
    return total

items = [100, 200, 300]
print("Total:", calculate_total(items))
