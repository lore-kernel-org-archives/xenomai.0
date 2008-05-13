Message-ID: <6132061f0805122051j6854ee1bm20577b53397a6783@domain.hid>
Date: Tue, 13 May 2008 00:51:28 -0300
From: "Breno Carneiro Pinheiro" <brenodee@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_4128_7890901.1210650688615"
Subject: [Xenomai-help] POSIX API
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

------=_Part_4128_7890901.1210650688615
Content-Type: multipart/alternative; 
	boundary="----=_Part_4129_2626104.1210650688615"

------=_Part_4129_2626104.1210650688615
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all, I wanna some help with my application. I'm learning about Xenomai
POSIX and Native API. I wonder know what is wrong with my code below because
both don't worked out:

POSIX:

#include <sys/mman.h>

#include <posix/pthread.h>
#include <posix/time.h>

#include <stdio.h>

static pthread_t task_desc;
void task_body (void *cookie)
 {
     struct timespec time;
     clock_gettime(CLOCK_MONOTONIC, &time);;
     pthread_make_periodic_np(pthread_self(),&time, 1000000000);
     while(1) {
     printf("%s\n","a");
     }
 }

int main (int argc, char *argv[])

 {
     int ret;
     pthread_attr_t thattr;

     pthread_attr_init(&thattr);
     pthread_attr_setdetachstate(&thattr, 0);
     pthread_attr_setstacksize(&thattr, 1024);
     ret = pthread_create(&task_desc, NULL, &task_body, NULL);

     if(!ret)
      pthread_join(task_desc, NULL);

 }

and NATIVE

#include <sys/mman.h>
#include <native/task.h>
#include <native/queue.h>
#include <native/intr.h>
#include <native/pipe.h>

#include <stdio.h>
#define TASK_PRIO  99 /* Highest RT priority */
#define TASK_MODE  0  /* No flags */
#define TASK_STKSZ 0  /* Stack size (use default one) */

RT_TASK task_desc;
RTIME period_ns =  1000000000llu;
void task_body (void *cookie)
 {
     unsigned long overrun;
     rt_task_set_periodic(NULL, TM_NOW, rt_timer_ns2ticks(period_ns));
     while(1) {
     rt_task_wait_period(&overrun);
     printf("%s\n","a");
     }
 }

int main (int argc, char *argv[])

 {
     int err;
     int ret;
     pthread_attr_t thattr;
     mlockall(MCL_CURRENT|MCL_FUTURE);

     err = rt_task_create(&task_desc,
                          "teste",
                          TASK_STKSZ,
                          TASK_PRIO,
                          TASK_MODE);


    if (!err)
         rt_task_start(&task_desc,&task_body,NULL);

     /* ... */
 }

 void cleanup (void)

 {
    rt_task_delete(&task_desc);
 }

I used the Makefile attached and tried to run on powerpc processor using
NFS.

Thanks,

Breno

------=_Part_4129_2626104.1210650688615
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all, I wanna some help with my application. I&#39;m learning about Xenomai POSIX and Native API. I wonder know what is wrong with my code below because both don&#39;t worked out:<br><br>POSIX:<br><br>#include &lt;sys/mman.h&gt;<br>
<br>#include &lt;posix/pthread.h&gt;<br>#include &lt;posix/time.h&gt;<br><br>#include &lt;stdio.h&gt; <br><br>static pthread_t task_desc;<br>void task_body (void *cookie)<br>&nbsp;{<br>&nbsp;&nbsp;&nbsp;&nbsp; struct timespec time;<br>&nbsp;&nbsp;&nbsp;&nbsp; clock_gettime(CLOCK_MONOTONIC, &amp;time);;<br>
&nbsp;&nbsp;&nbsp;&nbsp; pthread_make_periodic_np(pthread_self(),&amp;time, 1000000000);<br>&nbsp;&nbsp;&nbsp;&nbsp; while(1) {<br>&nbsp;&nbsp;&nbsp;&nbsp; printf(&quot;%s\n&quot;,&quot;a&quot;);<br>&nbsp;&nbsp;&nbsp;&nbsp; }<br>&nbsp;}<br>&nbsp;<br>int main (int argc, char *argv[])<br>&nbsp;<br>&nbsp;{<br>&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp; pthread_attr_t thattr;<br>&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp; pthread_attr_init(&amp;thattr);<br>&nbsp;&nbsp;&nbsp;&nbsp; pthread_attr_setdetachstate(&amp;thattr, 0);<br>&nbsp;&nbsp;&nbsp;&nbsp; pthread_attr_setstacksize(&amp;thattr, 1024);<br>&nbsp;&nbsp;&nbsp;&nbsp; ret = pthread_create(&amp;task_desc, NULL, &amp;task_body, NULL);<br>
&nbsp;&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp;&nbsp; if(!ret)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pthread_join(task_desc, NULL);<br>&nbsp;&nbsp;&nbsp; <br>&nbsp;}<br><br>and NATIVE<br><br>#include &lt;sys/mman.h&gt;<br>#include &lt;native/task.h&gt;<br>#include &lt;native/queue.h&gt;<br>#include &lt;native/intr.h&gt;<br>
#include &lt;native/pipe.h&gt;<br><br>#include &lt;stdio.h&gt; <br>#define TASK_PRIO&nbsp; 99 /* Highest RT priority */<br>#define TASK_MODE&nbsp; 0&nbsp; /* No flags */<br>#define TASK_STKSZ 0&nbsp; /* Stack size (use default one) */<br>&nbsp;<br>
RT_TASK task_desc;<br>RTIME period_ns =&nbsp; 1000000000llu;<br>void task_body (void *cookie)<br>&nbsp;{<br>&nbsp;&nbsp;&nbsp;&nbsp; unsigned long overrun;<br>&nbsp;&nbsp;&nbsp;&nbsp; rt_task_set_periodic(NULL, TM_NOW, rt_timer_ns2ticks(period_ns));<br>&nbsp;&nbsp;&nbsp;&nbsp; while(1) {<br>
&nbsp;&nbsp;&nbsp;&nbsp; rt_task_wait_period(&amp;overrun);<br>&nbsp;&nbsp;&nbsp;&nbsp; printf(&quot;%s\n&quot;,&quot;a&quot;);<br>&nbsp;&nbsp;&nbsp;&nbsp; }<br>&nbsp;}<br>&nbsp;<br>int main (int argc, char *argv[])<br>&nbsp;<br>&nbsp;{<br>&nbsp;&nbsp;&nbsp;&nbsp; int err;<br>&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>&nbsp;&nbsp;&nbsp;&nbsp; pthread_attr_t thattr;<br>
&nbsp;&nbsp;&nbsp;&nbsp; mlockall(MCL_CURRENT|MCL_FUTURE);<br>&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp; err = rt_task_create(&amp;task_desc,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;teste&quot;,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TASK_STKSZ,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TASK_PRIO,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TASK_MODE);<br>&nbsp;&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; if (!err)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rt_task_start(&amp;task_desc,&amp;task_body,NULL);<br>&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp; /* ... */<br>&nbsp;}<br><br>&nbsp;void cleanup (void)<br><br>&nbsp;{<br>&nbsp;&nbsp;&nbsp; rt_task_delete(&amp;task_desc);<br>
&nbsp;}<br><br>I used the Makefile attached and tried to run on powerpc processor using NFS.<br><br>Thanks,<br><br>Breno<br><br>

------=_Part_4129_2626104.1210650688615--

------=_Part_4128_7890901.1210650688615
Content-Type: application/octet-stream; name=Makefile
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fg5y4vuy0
Content-Disposition: attachment; filename=Makefile

IyMjIyMjIENPTkZJR1VSQVRJT04gIyMjIyMjCgojIyMgTGlzdCBvZiBhcHBsaWNhdGlvbnMgdG8g
YmUgYnVpbGQKQVBQTElDQVRJT05TID0gdGFza190ZXN0CgojIyMgTm90ZTogdG8gb3ZlcnJpZGUg
dGhlIHNlYXJjaCBwYXRoIGZvciB0aGUgeGVuby1jb25maWcgc2NyaXB0LCB1c2UgIm1ha2UgWEVO
Tz0uLi4iCgoKIyMjIExpc3Qgb2YgbW9kdWxlcyB0byBiZSBidWlsZApNT0RVTEVTID0KCiMjIyBO
b3RlOiB0byBvdmVycmlkZSB0aGUga2VybmVsIHNvdXJjZSBwYXRoLCB1c2UgIm1ha2UgS1NSQz0u
Li4iCgphbGw6OgoKI3Rhc2tfdGVzdDogdGFza190ZXN0LmMKCgojIyMjIyMgVVNFUiBTUEFDRSBC
VUlMRCAobm8gY2hhbmdlIHJlcXVpcmVkIG5vcm1hbGx5KSAjIyMjIyMKaWZlcSAoJChLRVJORUxS
RUxFQVNFKSwpCmlmbmVxICgkKEFQUExJQ0FUSU9OUyksKQoKIyMjIERlZmF1bHQgWGVub21haSBp
bnN0YWxsYXRpb24gcGF0aApYRU5PID89IC9ob21lL2JyZW5vL0VMREsvcHBjXzZ4eC91c3IvbG9j
YWwveGVub21haS8KClhFTk9DT05GSUc9JChzaGVsbCBQQVRIPSQoWEVOTyk6JChYRU5PKS9iaW46
JChQQVRIKSB3aGljaCB4ZW5vLWNvbmZpZyAyPi9kZXYvbnVsbCkKCiMjIyBTYW5pdHkgY2hlY2sK
aWZlcSAoJChYRU5PQ09ORklHKSwpCmFsbDo6CglAZWNobyAiPj4+IEludm9rZSBtYWtlIGxpa2Ug
dGhpczogXCJtYWtlIFhFTk89L3BhdGgvdG8veGVuby1jb25maWdcIiA8PDwiCglAZWNobwplbmRp
ZgoKCkNDPSQoc2hlbGwgJChYRU5PQ09ORklHKSAtLWNjKSAtSS91c3IvbG9jYWwveGVub21haS9p
bmNsdWRlCgpDRkxBR1M9LURDT05TVU1FUiAkKHNoZWxsICQoWEVOT0NPTkZJRykgLS1wb3NpeC1j
ZmxhZ3MpICQoQVBQX0NGTEFHUykKCkxERkxBR1M9JChzaGVsbCAkKFhFTk9DT05GSUcpIC0tcG9z
aXgtbGRmbGFncykgJChBUFBfTERGTEFHUykKCiMgVGhpcyBpbmNsdWRlcyB0aGUgbGlicmFyeSBw
YXRoIG9mIGdpdmVuIFhlbm9tYWkgaW50byB0aGUgYmluYXJ5IHRvIG1ha2UgbGl2ZQojIGVhc2ll
ciBmb3IgYmVnaW5uZXJzIGlmIFhlbm9tYWkncyBsaWJzIGFyZSBub3QgaW4gYW55IGRlZmF1bHQg
c2VhcmNoIHBhdGguCkxERkxBR1MrPS1YbGlua2VyIC1ycGF0aCAtWGxpbmtlciAkKHNoZWxsICQo
WEVOT0NPTkZJRykgLS1saWJkaXIpIC1scHNvcyAKCmFsbDo6ICQoQVBQTElDQVRJT05TKQoKY2xl
YW46OgoJJChSTSkgJChBUFBMSUNBVElPTlMpICoubwoKZW5kaWYKZW5kaWYKCgoKIyMjIyMjIEtF
Uk5FTCBNT0RVTEUgQlVJTEQgKG5vIGNoYW5nZSByZXF1aXJlZCBub3JtYWxseSkgIyMjIyMjCmlm
bmVxICgkKE1PRFVMRVMpLCkKCiMjIyBEZWZhdWx0IHRvIHNvdXJjZXMgb2YgY3VycmVudGx5IHJ1
bm5pbmcga2VybmVsCiNLU1JDID89IC9ob21lL2JyZW5vL0VMREsvcHBjXzZ4eC9saWIvbW9kdWxl
cy8kKHNoZWxsIHVuYW1lIC1yKS9idWlsZApLU1JDID89IC9ob21lL2JyZW5vL0VMREsvcHBjXzZ4
eC91c3Ivc3JjL0Rlbngta2VybmVsLXRyZWUtMgojS1NSQyA/PSAvbGliL21vZHVsZXMvJChzaGVs
bCB1bmFtZSAtcikvYnVpbGQKT0JKUyAgICAgOj0gJHtwYXRzdWJzdCAlLCAlLm8sICQoTU9EVUxF
Uyl9CkNMRUFOTU9EIDo9ICR7cGF0c3Vic3QgJSwgLiUqLCAkKE1PRFVMRVMpfQpQV0QgICAgICA6
PSAkKHNoZWxsIGlmIFsgIiQkUFdEIiAhPSAiIiBdOyB0aGVuIGVjaG8gJCRQV0Q7IGVsc2UgcHdk
OyBmaSkKCiMjIyBLZXJuZWwgMi42ClBBVENITEVWRUw6PSQoc2hlbGwgc2VkICdzL1BBVENITEVW
RUwgPSBcKC4qXCkvXDEvO3Q7ZCcgJChLU1JDKS9NYWtlZmlsZSkKaWZlcSAoJChQQVRDSExFVkVM
KSw2KQoKb2JqLW0gICAgICAgIDo9ICQoT0JKUykKRVhUUkFfQ0ZMQUdTIDo9IC1EUFJPRFVDRVIg
LUkkKEtTUkMpL2luY2x1ZGUveGVub21haSAtSSQoS1NSQykvaW5jbHVkZS94ZW5vbWFpL3Bvc2l4
ICQoQUREX0NGTEFHUykgCgphbGw6OgoJJChNQUtFKSAtQyAkKEtTUkMpIEFSQ0g9JChBUkNIKSBD
Uk9TU19DT01QSUxFPSQoQ1JPU1NfQ09NUElMRSkgU1VCRElSUz0kKFBXRCkgbW9kdWxlcwoJJChS
TSkgKi5vCgojIyMgS2VybmVsIDIuNAplbHNlCgpBUkNIICAgID89ICQoc2hlbGwgdW5hbWUgLWkp
CklOQ0xVREUgOj0gLUkkKEtTUkMpL2luY2x1ZGUveGVub21haSAtSSQoS1NSQykvaW5jbHVkZS94
ZW5vbWFpL2NvbXBhdCAtSSQoS1NSQykvaW5jbHVkZS94ZW5vbWFpL3Bvc2l4CkNGTEFHUyAgOj0g
JChzaGVsbCAkKE1BS0UpIC1zIC1DICQoS1NSQykgQ0M9JChDQykgQVJDSD0kKEFSQ0gpIFNVQkRJ
UlM9JChQV0QpIG1vZHVsZXMpICQoSU5DTFVERSkKCmFsbDo6ICQoT0JKUykKCmVuZGlmCgojIyBU
YXJnZXQgZm9yIGNhcHR1cmluZyAyLjQgbW9kdWxlIENGTEFHUwptb2R1bGVzOgoJQGVjaG8gIiQo
Q0ZMQUdTKSIKCmNsZWFuOjoKCSQoUk0pICQoQ0xFQU5NT0QpICoubyAqLmtvICoubW9kLmMgTW9k
dWxlKi5zeW12ZXJzCgkkKFJNKSAtUiAudG1wKgoJJChSTSkgLnJ1bmluZm8KCmVuZGlmCgo=
------=_Part_4128_7890901.1210650688615
Content-Type: application/octet-stream; name=Makefile.native
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fg5y5kmm1
Content-Disposition: attachment; filename=Makefile.native

IyMjIyMjIENPTkZJR1VSQVRJT04gIyMjIyMjCgojIyMgTGlzdCBvZiBhcHBsaWNhdGlvbnMgdG8g
YmUgYnVpbGQKI0FQUExJQ0FUSU9OUyA9IHRyaXZpYWwtcGVyaW9kaWMgc2lneGNwdSBydHByaW50
CkFQUExJQ0FUSU9OUyA9IHRhc2tfdGVzdF9uYXRpdmUKIyMjIE5vdGU6IHRvIG92ZXJyaWRlIHRo
ZSBzZWFyY2ggcGF0aCBmb3IgdGhlIHhlbm8tY29uZmlnIHNjcmlwdCwgdXNlICJtYWtlIFhFTk89
Li4uIgoKCiMjIyBMaXN0IG9mIG1vZHVsZXMgdG8gYmUgYnVpbGQKTU9EVUxFUyA9CgojIyMgTm90
ZTogdG8gb3ZlcnJpZGUgdGhlIGtlcm5lbCBzb3VyY2UgcGF0aCwgdXNlICJtYWtlIEtTUkM9Li4u
IgoKCgojIyMjIyMgVVNFUiBTUEFDRSBCVUlMRCAobm8gY2hhbmdlIHJlcXVpcmVkIG5vcm1hbGx5
KSAjIyMjIyMKaWZlcSAoJChLRVJORUxSRUxFQVNFKSwpCmlmbmVxICgkKEFQUExJQ0FUSU9OUyks
KQoKIyMjIERlZmF1bHQgWGVub21haSBpbnN0YWxsYXRpb24gcGF0aAojWEVOTyA/PSAvdXNyL3hl
bm9tYWkKWEVOTyA/PSAvaG9tZS9icmVuby9FTERLL3BwY182eHgvdXNyL2xvY2FsL3hlbm9tYWkv
ClhFTk9DT05GSUc9JChzaGVsbCBQQVRIPSQoWEVOTyk6JChYRU5PKS9iaW46JChQQVRIKSB3aGlj
aCB4ZW5vLWNvbmZpZyAyPi9kZXYvbnVsbCkKCiMjIyBTYW5pdHkgY2hlY2sKaWZlcSAoJChYRU5P
Q09ORklHKSwpCmFsbDo6CglAZWNobyAiPj4+IEludm9rZSBtYWtlIGxpa2UgdGhpczogXCJtYWtl
IFhFTk89L3BhdGgvdG8veGVuby1jb25maWdcIiA8PDwiCglAZWNobwplbmRpZgoKQ0M9JChzaGVs
bCAkKFhFTk9DT05GSUcpIC0tY2MpCgpDRkxBR1M9JChzaGVsbCAkKFhFTk9DT05GSUcpIC0teGVu
by1jZmxhZ3MpICQoTVlfQ0ZMQUdTKQoKTERGTEFHUz0kKHNoZWxsICQoWEVOT0NPTkZJRykgLS14
ZW5vLWxkZmxhZ3MpICQoTVlfTERGTEFHUykgLWxuYXRpdmUKCiMgVGhpcyBpbmNsdWRlcyB0aGUg
bGlicmFyeSBwYXRoIG9mIGdpdmVuIFhlbm9tYWkgaW50byB0aGUgYmluYXJ5IHRvIG1ha2UgbGl2
ZQojIGVhc2llciBmb3IgYmVnaW5uZXJzIGlmIFhlbm9tYWkncyBsaWJzIGFyZSBub3QgaW4gYW55
IGRlZmF1bHQgc2VhcmNoIHBhdGguCkxERkxBR1MrPS1YbGlua2VyIC1ycGF0aCAtWGxpbmtlciAk
KHNoZWxsICQoWEVOT0NPTkZJRykgLS1saWJkaXIpCgphbGw6OiAkKEFQUExJQ0FUSU9OUykKCmNs
ZWFuOjoKCSQoUk0pICQoQVBQTElDQVRJT05TKSAqLm8KCmVuZGlmCmVuZGlmCgoKCiMjIyMjIyBT
UEVDSUFMIFRBUkdFVCBSVUxFUyAjIyMjIyMKI3Rhc2tfdGVzdF9uYXRpdmU6IHRhc2tfdGVzdF9u
YXRpdmUuYwojCSQoQ0MpICQoQ0ZMQUdTKSAkPyAkKExERkxBR1MpIC1scnRkayAtbyAkQAojCSQo
Q0MpICQoQ0ZMQUdTKSAkPyAkKExERkxBR1MpIC1scHNvcyAtbyAkQAoKCgojIyMjIyMgS0VSTkVM
IE1PRFVMRSBCVUlMRCAobm8gY2hhbmdlIHJlcXVpcmVkIG5vcm1hbGx5KSAjIyMjIyMKaWZuZXEg
KCQoTU9EVUxFUyksKQoKIyMjIERlZmF1bHQgdG8gc291cmNlcyBvZiBjdXJyZW50bHkgcnVubmlu
ZyBrZXJuZWwKI0tTUkMgPz0gL2xpYi9tb2R1bGVzLyQoc2hlbGwgdW5hbWUgLXIpL2J1aWxkCktT
UkMgPz0gL2hvbWUvYnJlbm8vRUxESy9wcGNfNnh4L2xpYi9tb2R1bGVzLyQoc2hlbGwgdW5hbWUg
LXIpL2J1aWxkCgpPQkpTICAgICA6PSAke3BhdHN1YnN0ICUsICUubywgJChNT0RVTEVTKX0KQ0xF
QU5NT0QgOj0gJHtwYXRzdWJzdCAlLCAuJSosICQoTU9EVUxFUyl9ClBXRCAgICAgIDo9ICQoc2hl
bGwgaWYgWyAiJCRQV0QiICE9ICIiIF07IHRoZW4gZWNobyAkJFBXRDsgZWxzZSBwd2Q7IGZpKQoK
IyMjIEtlcm5lbCAyLjYKaWZlcSAoJChmaW5kc3RyaW5nIDIuNiwkKEtTUkMpKSwyLjYpCgpvYmot
bSAgICAgICAgOj0gJChPQkpTKQpFWFRSQV9DRkxBR1MgOj0gLUkkKEtTUkMpL2luY2x1ZGUveGVu
b21haSAtSSQoS1NSQykvaW5jbHVkZS94ZW5vbWFpL3Bvc2l4ICQoQUREX0NGTEFHUykKCmFsbDo6
CgkkKE1BS0UpIC1DICQoS1NSQykgU1VCRElSUz0kKFBXRCkgbW9kdWxlcwoKIyMjIEtlcm5lbCAy
LjQKZWxzZQoKQVJDSCAgICA/PSAkKHNoZWxsIHVuYW1lIC1pKQpJTkNMVURFIDo9IC1JJChLU1JD
KS9pbmNsdWRlL3hlbm9tYWkgLUkkKEtTUkMpL2luY2x1ZGUveGVub21haS9jb21wYXQgLUkkKEtT
UkMpL2luY2x1ZGUveGVub21haS9wb3NpeApDRkxBR1MgICs9ICQoc2hlbGwgJChNQUtFKSAtcyAt
QyAkKEtTUkMpIENDPSQoQ0MpIEFSQ0g9JChBUkNIKSBTVUJESVJTPSQoUFdEKSBtb2R1bGVzKSAk
KElOQ0xVREUpCgphbGw6OiAkKE9CSlMpCgplbmRpZgoKIyMgVGFyZ2V0IGZvciBjYXB0dXJpbmcg
Mi40IG1vZHVsZSBDRkxBR1MKbW9kdWxlczoKCUBlY2hvICIkKENGTEFHUykiCgpjbGVhbjo6Cgkk
KFJNKSAkKENMRUFOTU9EKSAqLm8gKi5rbyAqLm1vZC5jIE1vZHVsZSouc3ltdmVycwoJJChSTSkg
LVIgLnRtcCoKCmVuZGlmCg==
------=_Part_4128_7890901.1210650688615--

