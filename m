Message-ID: <cbe23c50705151054x779cccb0v2128d3b8ca1bfa87@domain.hid>
Date: Tue, 15 May 2007 19:54:46 +0200
From: "Eric Noulard" <eric.noulard@domain.hid>
In-Reply-To: <DD39B5C3F4963040ADC9768BE7E430CB01EB2122@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_4166_19303486.1179251686553"
References: <DD39B5C3F4963040ADC9768BE7E430CB01EB2004@domain.hid>
	<4649A485.5010102@domain.hid>
	<DD39B5C3F4963040ADC9768BE7E430CB01EB20E6@domain.hid>
	<4649C8B6.2050304@domain.hid>
	<DD39B5C3F4963040ADC9768BE7E430CB01EB2122@domain.hid>
Subject: Re: [Xenomai-help] memcpy performance on Xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Daniel Schnell <daniel.schnell@domain.hid>
Cc: xenomai@xenomai.org

------=_Part_4166_19303486.1179251686553
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

2007/5/15, Daniel Schnell <daniel.schnell@domain.hid>:
> Hi,
>
> Some interesting insights about my last tests.
>
> 1.) The culprit is mlockall(MCL_FUTURE|MCL_CURRENT);
>
> As soon I leave this away, I get much better results:
>
> Without mlockall():
> Test (10) memcpy of sizes (10485760)
> 10 memcpy. Time per memcpy: 78147209 [nsec] (134 MB/sec)
>  finished.
>
> With mlockall():
> Test (10) memcpy of sizes (10485760) ....
> 10 memcpy. Time per memcpy: 124194618 [nsec] (84 MB/sec)
>  finished.


I think you are not measuring the same thing in both case.
I did some test on 2.6.20 (precompiled debian etch kernel)
on a 1.6 GHz Pentium M.

I think the fact that you malloced your buffer and then
immediatly memcpy the buffers does a non repeatable measure
(at least on my side)
depending on something I do not understand .

Could you try my modified version of your code which
adds:

memset(buf1,'\0',msgsize);
memset(buf2,'\0',msgsize);

just after malloc (you may try calloc too).

With this modification
I get similar figure for the mlockall version on my (quasi)-vanilla kernel.

that is:

./memcpy_perf_mlockall
Test (10) memcpy of sizes (10485760) ....
10 memcpy. Time per memcpy: 35716568 [nsec] (293 MB/sec)
 finished.

./memcpy_perf_memset
Test (10) memcpy of sizes (10485760) ....
10 memcpy. Time per memcpy: 36004454 [nsec] (291 MB/sec)
 finished.

./memcpy_perf
Test (10) memcpy of sizes (10485760) ....
10 memcpy. Time per memcpy: 23881352 [nsec] (439 MB/sec)
 finished.


I think that without mlockall or no memset the memory pages you
requested with malloc and did not --really-- get are brought to
physical memory only when memcpy comes.

What puzzles me is WHY it is faster WITHOUT touching the page
BEFORE memcpy???

Any memory handling expert is welcomed to answer.

> Then again I cannot use Xenomai without mlockall()
> :(

And you cannot design a realtime application without
ensuring you really have the memory you requested,
this is not a xenomai issue (my opinion though).

PS: on line compilation used:

gcc memcpy_perf-erk.c -o memcpy_perf -lrt
gcc -DMLOCK memcpy_perf-erk.c -o memcpy_perf_mlockall -lrt
gcc -DMEMSET memcpy_perf-erk.c -o memcpy_perf_memset -lrt

-- 
Erk

------=_Part_4166_19303486.1179251686553
Content-Type: text/x-csrc; name=memcpy_perf-erk.c; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f1qnu6jq
Content-Disposition: attachment; filename="memcpy_perf-erk.c"

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzdGRsaWIuaD4KI2luY2x1ZGUgPHN5cy90aW1l
Lmg+CiNpbmNsdWRlIDxwdGhyZWFkLmg+CiNpbmNsdWRlIDxzdHJpbmcuaD4KI2luY2x1ZGUgPHN5
cy9tbWFuLmg+CgppbnQgb3NhX25vd190aW1lc3BlYyhzdHJ1Y3QgdGltZXNwZWMqIHQpCnsKCXJl
dHVybiBjbG9ja19nZXR0aW1lIChDTE9DS19SRUFMVElNRSwgdCk7Cn0KCgppbnQgb3NhX3RpbWVk
aWZmKGNvbnN0IHN0cnVjdCB0aW1lc3BlYyogdDEsIGNvbnN0IHN0cnVjdCB0aW1lc3BlYyogdDIs
IHN0cnVjdCB0aW1lc3BlYyogZGlmZikKewoJaWYgKHQxIT1OVUxMICYmIHQyIT1OVUxMICYmIGRp
ZmYhPU5VTEwpCgl7CgkJdW5zaWduZWQgbG9uZyBsb25nIGFfbnNlYywgYl9uc2VjLCBkaWZmX25z
ZWM7IAoKCQkvLyBjYWxjdWxhdGUgZGlmZmVyZW5jZSB0aW1lCgkJYV9uc2VjID0gdDEtPnR2X3Nl
YyoxMDAwMDAwMDAwVUxMICsgdDEtPnR2X25zZWM7CgkJYl9uc2VjID0gdDItPnR2X3NlYyoxMDAw
MDAwMDAwVUxMICsgdDItPnR2X25zZWM7CgkJZGlmZl9uc2VjID0gYl9uc2VjIC0gYV9uc2VjOwoJ
CWRpZmYtPnR2X3NlYyA9ICBkaWZmX25zZWMvMTAwMDAwMDAwMFVMTDsKCQlkaWZmLT50dl9uc2Vj
ID0gZGlmZl9uc2VjJTEwMDAwMDAwMDBVTEw7CgkJcmV0dXJuIDA7Cgl9CglyZXR1cm4gLTE7Cn0K
Cgp1bnNpZ25lZCBsb25nIGxvbmcgb3NhX3RvX25zKGNvbnN0IHN0cnVjdCB0aW1lc3BlYyogdCkK
ewoJIHJldHVybiAodC0+dHZfc2VjKjEwMDAwMDAwMDBVTEwgKyB0LT50dl9uc2VjKTsKfQoKCmlu
dCB0ZXN0TWVtY3B5KHVuc2lnbmVkIGxvbmcgbnVtLCBzaXplX3QgbXNnc2l6ZSkKewoJcHJpbnRm
KCJUZXN0ICglbGQpIG1lbWNweSBvZiBzaXplcyAoJWxkKSAuLi4uXG4iLAogICAgICAgICAgICBu
dW0sIG1zZ3NpemUpOwogICAgdW5zaWduZWQgbG9uZyBpOwogICAgdW5zaWduZWQgbG9uZyBsb25n
IG5zdGltZTsKICAgIHN0cnVjdCB0aW1lc3BlYyB0MSwgdDIsIHQzOwoKICAgIGNoYXIgKmJ1ZjE9
bWFsbG9jIChtc2dzaXplKTsKICAgIGNoYXIgKmJ1ZjI9bWFsbG9jIChtc2dzaXplKTsKI2lmZGVm
IE1FTVNFVAogICAgbWVtc2V0KGJ1ZjEsJ1wwJyxtc2dzaXplKTsKICAgIG1lbXNldChidWYyLCdc
MCcsbXNnc2l6ZSk7CiNlbmRpZgogICAgLy8gbWVhc3VyZQoJb3NhX25vd190aW1lc3BlYygmdDEp
OwogICAgZm9yIChpPTA7IGk8bnVtOyBpKyspCiAgICAgICAgewogICAgICAgIG1lbWNweSAoYnVm
MSwgYnVmMiwgbXNnc2l6ZSk7CiAgICAgICAgfQogICAgLy8gbWVhc3VyZQoJb3NhX25vd190aW1l
c3BlYygmdDIpOwoJb3NhX3RpbWVkaWZmKCZ0MSwgJnQyLCAmdDMpOwogICAgCiAgICBmcmVlIChi
dWYyKTsKICAgIGZyZWUgKGJ1ZjEpOwogICAgCiAgICBuc3RpbWUgPSBvc2FfdG9fbnMoJnQzKS8o
dW5zaWduZWQgbG9uZyBsb25nKSBpOwoJcHJpbnRmKCIlbGQgbWVtY3B5LiBUaW1lIHBlciBtZW1j
cHk6ICVsbHUgW25zZWNdICglbGx1IE1CL3NlYylcbiIsCiAgICAgICAgICAgIGksIG5zdGltZSwK
ICAgICAgICAgICAgKDEwMDBVTEwgKiAodW5zaWduZWQgbG9uZyBsb25nKSBtc2dzaXplKS8obnN0
aW1lKSkgOwogICAgZmZsdXNoIChzdGRvdXQpOwoKCglwcmludGYoIiBmaW5pc2hlZC5cbiIpOwog
ICAgZmZsdXNoIChzdGRvdXQpOwp9CgoKaW50IG1haW4oKQp7CiNpZmRlZiBNTE9DSwogICAgbWxv
Y2thbGwoTUNMX0ZVVFVSRXxNQ0xfQ1VSUkVOVCk7CiNlbmRpZgogICAgdGVzdE1lbWNweSgxMDAw
MCwgICAgICAxKjEwMjQpOwogICAgdGVzdE1lbWNweSgxMDAwMCwgICAgICAyKjEwMjQpOwogICAg
dGVzdE1lbWNweSgxMDAwMCwgICAgICA0KjEwMjQpOwogICAgdGVzdE1lbWNweSgxMDAwMCwgICAg
ICA4KjEwMjQpOwogICAgdGVzdE1lbWNweSgxMDAwMCwgICAgIDE2KjEwMjQpOwogICAgdGVzdE1l
bWNweSgxMDAwICwgICAgIDMyKjEwMjQpOwogICAgdGVzdE1lbWNweSgxMDAwICwgICAgIDUwKjEw
MjQpOwogICAgdGVzdE1lbWNweSgxMDAwICwgICAgMTAwKjEwMjQpOwogICAgdGVzdE1lbWNweSgg
MTAwICwgICAxMDI0KjEwMjQpOwogICAgdGVzdE1lbWNweSggIDEwICwxMCoxMDI0KjEwMjQpOwog
ICAgdGVzdE1lbWNweSggICA1ICw1MCoxMDI0KjEwMjQpOwoKICAgIHJldHVybiAwOwp9Cg==
------=_Part_4166_19303486.1179251686553--

