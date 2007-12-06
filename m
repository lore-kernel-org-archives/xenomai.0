Message-ID: <2ff1a98a0712060621k436f32b7sc1d1cfe53bea8f18@domain.hid>
Date: Thu, 6 Dec 2007 15:21:47 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <475801AA.3060300@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_8602_26086080.1196950907248"
References: <4757EBAE.4050608@domain.hid>
	<2ff1a98a0712060513g3b056866x883691498daf00e1@domain.hid>
	<4757F811.70905@domain.hid>
	<2ff1a98a0712060528y13159abdwb83617a8744b3735@domain.hid>
	<2ff1a98a0712060544x6e1e8c11q52e9417fb096e4b7@domain.hid>
	<475801AA.3060300@domain.hid>
Subject: Re: [Xenomai-core] How to cancel a Xenomai POSIX thread
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

------=_Part_8602_26086080.1196950907248
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Dec 6, 2007 3:05 PM, Wolfgang Grandegger <wg@domain.hid> wrote:
>
> Gilles Chanteperdrix wrote:
> > On Dec 6, 2007 2:28 PM, Gilles Chanteperdrix
> > <gilles.chanteperdrix@xenomai.org> wrote:
> >> On Dec 6, 2007 2:24 PM, Wolfgang Grandegger <wg@domain.hid> wrote:
> >>> Gilles Chanteperdrix wrote:
> >>>> On Dec 6, 2007 1:31 PM, Wolfgang Grandegger <wg@domain.hid> wrote:
> >>>>> Hello,
> >>>>>
> >>>>> how do I cancel or delete a Xenomai POSIX thread running in primary
> >>>>> context from a higher priority thread? IIUC, pthread_kill() can only be
> >>>>> used in secondary context. I tried pthread_cancel(), but it only works
> >>>>> when hitting a cancelation point, e.g. pthread_testcancel(). Setting
> >>>>> pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS) did not help. Is
> >>>>> there a code snippet or even an example program showing how to cancel a
> >>>>> pthread in primary context?
> >>>> pthread_kill or pthread_cancel should result in sending a signal to
> >>>> the target thread, so should cause this thread to switch to secondary
> >>>> mode to handle it. If you want to wait for the target thread to be
> >>>> canceled, you should use pthread_cancel and pthread_join.
> >>> There is no way to cancel a pthread in primary mode from another pthread?
> >> No. You always need secondary mode to effectively delete a thread. The
> >> same goes for the native skin.
> >
> > Ok. I understand what you mean. You want pthread_cancel not to leave
> > primary mode. This can easily be done by causing pthread_cancel to use
> > the kernel-space real-time pthread_cancel service. This should work
> > with no further modification.
>
> I want to cancel/delete a task running in primary mode, e.g.
>
>   void* work_task(void* dummy)
>   {
>         int count = 0;
>         while (1)
>                 count++;
>   }
>
> from the outside (= another higher priority task). How can I use the
> kernel-space real-time pthread_cancel service? My POSIX app is runs in
> user-land.

I was thinking about adding a pthread_cancel syscall that would have
triggered the kernel-space pthread_cancel. But this will not work:
user-space cleanup handlers would no longer get executed. However,
this can work for pthread_kill. Here is a patch which adds the
pthread_kill syscall.


-- 
                                               Gilles Chanteperdrix

------=_Part_8602_26086080.1196950907248
Content-Type: application/octet-stream;
 name=xeno-posix-primary-mode-pthread_kill.diff
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f9vdn3z80
Content-Disposition: attachment;
 filename=xeno-posix-primary-mode-pthread_kill.diff

SW5kZXg6IGluY2x1ZGUvcG9zaXgvc3lzY2FsbC5oCj09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIGluY2x1ZGUvcG9z
aXgvc3lzY2FsbC5oCShyw6l2aXNpb24gMzI0MikKKysrIGluY2x1ZGUvcG9zaXgvc3lzY2FsbC5o
CShjb3BpZSBkZSB0cmF2YWlsKQpAQCAtOTksNiArOTksNyBAQAogI2RlZmluZSBfX3BzZTUxX2Nv
bmRhdHRyX2dldHBzaGFyZWQgICA3MwogI2RlZmluZSBfX3BzZTUxX2NvbmRhdHRyX3NldHBzaGFy
ZWQgICA3NAogI2RlZmluZSBfX3BzZTUxX3RocmVhZF9nZXRzY2hlZHBhcmFtICA3NQorI2RlZmlu
ZSBfX3BzZTUxX3RocmVhZF9raWxsICAgICAgICAgICA3NgogCiAjaWZkZWYgX19LRVJORUxfXwog
CkluZGV4OiBzcmMvc2tpbnMvcG9zaXgvdGhyZWFkLmMKPT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gc3JjL3NraW5z
L3Bvc2l4L3RocmVhZC5jCShyw6l2aXNpb24gMzI0MikKKysrIHNyYy9za2lucy9wb3NpeC90aHJl
YWQuYwkoY29waWUgZGUgdHJhdmFpbCkKQEAgLTI0NSwzICsyNDUsMTUgQEAKIAlyZXR1cm4gLVhF
Tk9NQUlfU0tJTkNBTEwyKF9fcHNlNTFfbXV4aWQsCiAJCQkJICBfX3BzZTUxX3RocmVhZF9zZXRf
bmFtZSwgdGhyZWFkLCBuYW1lKTsKIH0KKworaW50IF9fd3JhcF9wdGhyZWFkX2tpbGwocHRocmVh
ZF90IHRocmVhZCwgaW50IHNpZykKK3sKKwlpbnQgZXJyOworCWVyciA9IC1YRU5PTUFJX1NLSU5D
QUxMMihfX3BzZTUxX211eGlkLAorCQkJCSBfX3BzZTUxX3RocmVhZF9raWxsLCB0aHJlYWQsIHNp
Zyk7CisKKwlpZiAoZXJyID09IEVTUkNIKQorCQlyZXR1cm4gX19yZWFsX3B0aHJlYWRfa2lsbCh0
aHJlYWQsIHNpZyk7CisKKwlyZXR1cm4gZXJyOworfQpJbmRleDogc3JjL3NraW5zL3Bvc2l4L3Bv
c2l4LndyYXBwZXJzCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIHNyYy9za2lucy9wb3NpeC9wb3NpeC53cmFwcGVy
cwkocsOpdmlzaW9uIDMyNDIpCisrKyBzcmMvc2tpbnMvcG9zaXgvcG9zaXgud3JhcHBlcnMJKGNv
cGllIGRlIHRyYXZhaWwpCkBAIC0zLDYgKzMsNyBAQAogLS13cmFwIHB0aHJlYWRfZ2V0c2NoZWRw
YXJhbQogLS13cmFwIHB0aHJlYWRfeWllbGQKIC0td3JhcCBzY2hlZF95aWVsZAorLS13cmFwIHB0
aHJlYWRfa2lsbAogLS13cmFwIHNlbV9pbml0CiAtLXdyYXAgc2VtX2Rlc3Ryb3kKIC0td3JhcCBz
ZW1fcG9zdApJbmRleDoga3NyYy9za2lucy9wb3NpeC9zeXNjYWxsLmMKPT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0g
a3NyYy9za2lucy9wb3NpeC9zeXNjYWxsLmMJKHLDqXZpc2lvbiAzMjQyKQorKysga3NyYy9za2lu
cy9wb3NpeC9zeXNjYWxsLmMJKGNvcGllIGRlIHRyYXZhaWwpCkBAIC0zOTYsNiArMzk2LDIxIEBA
CiAJcmV0dXJuIC1wdGhyZWFkX3NldF9uYW1lX25wKGtfdGlkLCBuYW1lKTsKIH0KIAorc3RhdGlj
IGludCBfX3B0aHJlYWRfa2lsbChzdHJ1Y3QgdGFza19zdHJ1Y3QgKmN1cnIsIHN0cnVjdCBwdF9y
ZWdzICpyZWdzKQoreworCXN0cnVjdCBwc2U1MV9oa2V5IGhrZXk7CisJcHRocmVhZF90IGtfdGlk
OworCisJaGtleS51X3RpZCA9IF9feG5fcmVnX2FyZzEocmVncyk7CisJaGtleS5tbSA9IGN1cnIt
Pm1tOworCWtfdGlkID0gX19wdGhyZWFkX2ZpbmQoJmhrZXkpOworCisJaWYoIWtfdGlkKQorCQly
ZXR1cm4gLUVTUkNIOworCisJcmV0dXJuIC1wdGhyZWFkX2tpbGwoa190aWQsIF9feG5fcmVnX2Fy
ZzIocmVncykpOworfQorCiBzdGF0aWMgaW50IF9fc2VtX2luaXQoc3RydWN0IHRhc2tfc3RydWN0
ICpjdXJyLCBzdHJ1Y3QgcHRfcmVncyAqcmVncykKIHsKIAl1bmlvbiBfX3hlbm9fc2VtIHNtLCAq
dXNtOwpAQCAtMjY1Myw2ICsyNjY4LDcgQEAKIAlbX19wc2U1MV90aHJlYWRfd2FpdF0gPSB7Jl9f
cHRocmVhZF93YWl0X25wLCBfX3huX2V4ZWNfcHJpbWFyeX0sCiAJW19fcHNlNTFfdGhyZWFkX3Nl
dF9tb2RlXSA9IHsmX19wdGhyZWFkX3NldF9tb2RlX25wLCBfX3huX2V4ZWNfcHJpbWFyeX0sCiAJ
W19fcHNlNTFfdGhyZWFkX3NldF9uYW1lXSA9IHsmX19wdGhyZWFkX3NldF9uYW1lX25wLCBfX3hu
X2V4ZWNfYW55fSwKKwlbX19wc2U1MV90aHJlYWRfa2lsbF0gPSB7Jl9fcHRocmVhZF9raWxsLCBf
X3huX2V4ZWNfYW55fSwKIAlbX19wc2U1MV9zZW1faW5pdF0gPSB7Jl9fc2VtX2luaXQsIF9feG5f
ZXhlY19hbnl9LAogCVtfX3BzZTUxX3NlbV9kZXN0cm95XSA9IHsmX19zZW1fZGVzdHJveSwgX194
bl9leGVjX2FueX0sCiAJW19fcHNlNTFfc2VtX3Bvc3RdID0geyZfX3NlbV9wb3N0LCBfX3huX2V4
ZWNfYW55fSwK
------=_Part_8602_26086080.1196950907248--

