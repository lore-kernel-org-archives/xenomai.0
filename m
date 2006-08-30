Message-ID: <b647ffbd0608301025i285f8a35k6b0b738afb888d9@domain.hid>
Date: Wed, 30 Aug 2006 19:25:06 +0200
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
In-Reply-To: <b647ffbd0608301010m52b024fbibc444e10f4a42958@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_27676_10603072.1156958706726"
References: <b647ffbd0608291228i58bfa3fex5e8f3e18dc0ecc0@domain.hid>
	<44F49A6C.5050603@domain.hid>
	<b647ffbd0608291334u4182e78bub6d874e252abbbc9@domain.hid>
	<44F592AD.2000900@domain.hid>
	<b647ffbd0608301010m52b024fbibc444e10f4a42958@domain.hid>
Subject: [Xenomai-core] Re: [patch, RFC] detect unhandled interrupts
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>, Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

------=_Part_27676_10603072.1156958706726
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 30/08/06, Dmitry Adamushko <dmitry.adamushko@domain.hid> wrote:


(cache line == 128 bits) let's say cacheline[4]
>
> int a = 1;   // e.g. &a == 0xabcd0004
>
> this part of memory is currently not in the cache. So :
>
> 1) [0xabcd0000, 0xabcd0010] == 128 bits is loaded from memory into
> cacheline.
>


Nop, it looks wrong. Ignore this part :)



2) then 1 is loaded into cacheline[1]
>
> 3) [ write-through ] ---> sync with memory
> or
>     [ write-back ] ---> delay synching
>
>  ?
>
>
> Jan
> >
> >
> >
>
> --
> Best regards,
> Dmitry Adamushko
>



-- 
Best regards,
Dmitry Adamushko

------=_Part_27676_10603072.1156958706726
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div><span class="gmail_quote">On 30/08/06, <b class="gmail_sendername">Dmitry Adamushko</b> &lt;<a href="mailto:dmitry.adamushko@domain.hid">dmitry.adamushko@domain.hid</a>&gt; wrote:</span><div><br>
&nbsp;</div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div><div><div>
(cache line == 128 bits) let's say cacheline[4]<br>
<br>
int a = 1;&nbsp;&nbsp; // e.g. &amp;a == 0xabcd0004<br>
<br>
this part of memory is currently not in the cache. So :<br>
<br>
1) [0xabcd0000, 0xabcd0010] == 128 bits is loaded from memory into cacheline.</div></div></div></blockquote><div><br>
<br>
Nop, it looks wrong. Ignore this part :)<br>
&nbsp;<br>
<br>
</div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div><div><div>
2) then 1 is loaded into cacheline[1]<br>
<br>
3) [ write-through ] ---&gt; sync with memory<br>
or<br>
&nbsp; &nbsp; [ write-back ] ---&gt; delay synching<br>
<br>
&nbsp;?</div><br>
<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Jan<br><br><br>
</blockquote></div><br clear="all"><br>-- <br>Best regards,<br></div><div><span class="sg">Dmitry Adamushko

</span></div></blockquote></div><br><br clear="all"><br>-- <br>Best regards,<br>Dmitry Adamushko

------=_Part_27676_10603072.1156958706726--

