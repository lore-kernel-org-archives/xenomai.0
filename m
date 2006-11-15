Message-ID: <b647ffbd0611150519w1a510582n40782bdccaa7562d@domain.hid>
Date: Wed, 15 Nov 2006 14:19:38 +0100
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-help] Kernel crash during queue create/destroy
In-Reply-To: <200611151121.51836.s.zimmermann@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_2284_8775969.1163596778615"
References: <200611151121.51836.s.zimmermann@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Stephan Zimmermann <s.zimmermann@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

------=_Part_2284_8775969.1163596778615
Content-Type: multipart/alternative; 
	boundary="----=_Part_2285_25996855.1163596778615"

------=_Part_2285_25996855.1163596778615
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

I got some trouble with the native skin and queues, when creating / deleting
> queues, my Kernel sometimes (actually very often...) crashes, leading to a
> frozen system, with my Xenomai program continuing until it returns. I
> tried
> to isolate / reproduce the problem, which lead me to the following
> demo-code.
>
>
it looks like there is some "misunderstanding" between

(1) rt_queue_delete() -> xnregistry_remove()

and

(2) registry_proc_callback() which crushes in remove_proc_entry().

You may follow the logic in ksrc/nucleus/registry.c.

rt_queue_create() -> xnregistry_enter() -> ... -> registry_proc_callback()

rt_queue_delete() -> xnregistry_remove() -> ... registry_proc_unexport()

I don't have enough time to investigate further right now, but nevertheless,
could you apply the following patch and let us know of the outcome?


-- 
Best regards,
Dmitry Adamushko

------=_Part_2285_25996855.1163596778615
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br>
Hello,<br>
<br><div><span class="gmail_quote"></span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">I got some trouble with the native skin and queues, when creating / deleting
<br>queues, my Kernel sometimes (actually very often...) crashes, leading to a<br>frozen system, with my Xenomai program continuing until it returns. I tried<br>to isolate / reproduce the problem, which lead me to the following demo-code.
<br><br></blockquote></div><br>
it looks like there is some &quot;misunderstanding&quot; between<br>
<br>
(1) rt_queue_delete() -&gt; xnregistry_remove()<br>
<br>
and<br>
<br>
(2) registry_proc_callback() which crushes in remove_proc_entry().<br>
<br>
You may follow the logic in ksrc/nucleus/registry.c.<br>
<br>
rt_queue_create() -&gt; xnregistry_enter() -&gt; ... -&gt; registry_proc_callback()<br>
<br>
rt_queue_delete() -&gt; xnregistry_remove() -&gt; ... registry_proc_unexport()<br>
<br>
I don't have enough time to investigate further right now, but
nevertheless, could you apply the following patch and let us know of
the outcome?<br>
<br>
<br>-- <br>Best regards,<br>Dmitry Adamushko<br>
<br>


------=_Part_2285_25996855.1163596778615--

------=_Part_2284_8775969.1163596778615
Content-Type: text/x-patch; name=registry-test.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_eujrg46n
Content-Disposition: attachment; filename="registry-test.patch"

LS0tIGtzcmMvbnVjbGV1cy9yZWdpc3RyeS1vbGQuYwkyMDA2LTExLTE1IDE0OjEwOjAyLjg3Nzc0
NDAwMCArMDEwMAorKysga3NyYy9udWNsZXVzL3JlZ2lzdHJ5LmMJMjAwNi0xMS0xNSAxNDoxNDo0
NC4zMzUxNzMwMDAgKzAxMDAKQEAgLTQwNCw3ICs0MDQsMTAgQEAgc3RhdGljIGlubGluZSB2b2lk
IHJlZ2lzdHJ5X3Byb2NfZXhwb3J0KAogCiBzdGF0aWMgaW5saW5lIHZvaWQgcmVnaXN0cnlfcHJv
Y191bmV4cG9ydCh4bm9iamVjdF90ICpvYmplY3QpCiB7Ci0JaWYgKG9iamVjdC0+cHJvYyAhPSBY
Tk9CSkVDVF9QUk9DX1JFU0VSVkVEMSkgeworCWlmICghb2JqZWN0LT5wcm9jIHx8IG9iamVjdC0+
cHJvYyA9PSBYTk9CSkVDVF9QUk9DX1JFU0VSVkVEMikKKwkJcHJpbnRrKEtFUk5fSU5GTyAiKioq
IG9iamVjdC0+cHJvYyA9PSAleCAqKipcbiIsIG9iamVjdC0+cHJvYyk7CisKKwlpZiAoKHVuc2ln
bmVkIGxvbmcpb2JqZWN0LT5wcm9jID4gKHVuc2lnbmVkIGxvbmcpWE5PQkpFQ1RfUFJPQ19SRVNF
UlZFRDIpIHsKIAkJcmVtb3ZlcSgmcmVnaXN0cnlfb2JqX2J1c3lxLCAmb2JqZWN0LT5saW5rKTsK
IAkJYXBwZW5kcSgmcmVnaXN0cnlfb2JqX3VuZXhwb3J0cSwgJm9iamVjdC0+bGluayk7CiAJCXJ0
aGFsX2FwY19zY2hlZHVsZShyZWdpc3RyeV9wcm9jX2FwYyk7Cg==
------=_Part_2284_8775969.1163596778615--

