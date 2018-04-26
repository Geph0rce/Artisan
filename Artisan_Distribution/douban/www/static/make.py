print "make css..."
r = open('css/retina.css', 'w')
r1 = open('css/icon480.css', 'w')
r2 = open('css/icon240.css', 'w')

for i in open('css/iphone.css'):
    if '.png)' in i or '.gif)' in i:
        k = i.replace('/320/', '/640/')
        k1 = i.replace('/320/', '/480/')
        k2 = i.replace('/320/', '/240/')
        r.write(k)
        r1.write(k1)
        r2.write(k2)

r.close();
r1.close();
r2.close();
