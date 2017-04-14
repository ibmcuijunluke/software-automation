247  clear
248  ls
249  cd /opt
250  ls
251  sz copytest.yml
252  sz createuser.yml
253  sz pingserver.yml
254  sz testserver.yml
255  ls
256  history
257  cat /mnt/data/pgsql/pg_hba.conf
258  history
259  chown -R wisdom.wisdom /mnt/{data,log}/pgsql
260  clear
261  su wisdom
262  ls
263  pg_dump -h localhost -p 5432 -U grp_dev -W -F c -b -v -f "grp_dev.backup" grp_dev
264  ls
265  sz grp_dev.backup
266  ls -ll
267  pg_dump -h localhost -p 5432 -U pcm_dev -W -F c -b -v -f "grp_dev.backup" pcm_dev
268  ls
269  pg_dump -h localhost -p 5432 -U pcm_dev -W -F c -b -v -f "pcm_dev.backup" pcm_dev
270  ls
271  sz pcm_dev.backup
272  ls -ll
273  clear
274  ls
275  pg_dump -h localhost -p 5432 -U pms_dev -W -F c -b -v -f "pms_dev.backup" pms_dev
276  ls
277  sz pms_dev.backup
278  clear
279  ls -ll
280  history
281  ls
282  rm -rf jw_platform.dump
283  ls -ll
284  pg_dump -h localhost -p 5432 -U platform -W -F c -b -v -f "jw_platform.backup" platform
285  pg_dump -h localhost -p 5432 -U platform -W -F c -b -v -f "jw_platform.backup" jw_platform
286  ls
287  sz jw_platform.backup
288  ls -ll
289  rm -f *.backup
290  ls -ll
291  rm -f *.dump
292  ls -ll
293  pg_dump -h localhost -p 5432 -U grp_dev -W -F c -b -v -f "grp_dev.backup" grp_dev
294  ls -ll
295  pg_dump -h localhost -p 5432 -U pcm_dev -W -F c -b -v -f "pcm_dev.backup" pcm_dev
296  ls -ll
297  pg_dump -h localhost -p 5432 -U pms_dev -W -F c -b -v -f "pms_dev.backup" pms_dev
298  ls -ll
299  rz grp_dev.backup
300  sz grp_dev.backup
301  sz pcm_dev.backup
302  sz pms_dev.backup
303  clear
304  ls -ll
305  /mnt/app/pgsql/bin/psql -d postgres
306  su wisdom
307  pg_dump -h 192.168.18.221 grp_dev -U wisdom --password -f grp_dev.dump
308  ls
309  ls -ll
310  pg_dump -h 192.168.18.221 pcm_dev -U wisdom --password -f pcm_dev.dump
311  pg_dump -h 192.168.18.221 pms_dev -U wisdom --password -f pms_dev.dump
312  pg_dump -h 192.168.18.221 jw_platform -U wisdom --password -f jw_platform.dump
313  clear
314  ls
315  ls -ll
316  history
317  pg_dump -h 192.168.18.221 jw_platform -U wisdom --password -f jw_platform.dump
318  rpm -qa |grep postgresql
319  su wisdom
320  ls
321  ls -ll
322  pg_restore --version
323  pg_restore -h 192.168.18.221 -p 5432 -U wisdom -W -d jw_platform -v "jw_platform.dump"
324  pg_dump -h localhost -p 5432 -U wisdom -W -F c -b -v -f "/home/root/grp_dev.backup" grp_dev
325  pg_dump -h localhost -p 5432 -U wisdom -W -F c -b -v -f "grp_dev.backup" grp_dev
326  ls
327  ls -ll
328  pg_restore -h localhost -p 5432 -U wisdom -W -d grp_dev -v "grp_dev.backup"
329  clear
330  ls
331  ls -ll
332  history
333  clear
334  LS
335  ls
336  pg_dump -h localhost -p 5432 -U grp_dev -W -F c -b -v -f "grp_dev.backup" grp_dev
337  clear
338  pg_restore -h localhost -p 5432 -U grp_dev -W -d grp_dev -v "grp_dev.backup"
339  clear
340  ls
341  history
