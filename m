Message-ID: <b647ffbd0608101118k622eb03cudf12906a44410529@domain.hid>
Date: Thu, 10 Aug 2006 20:18:37 +0200
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-core] Re: [Xenomai-help] -110 error on rt_task_send...
	bug?
In-Reply-To: <44DB778A.5050004@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_31362_27157360.1155233917610"
References: <44D7EDCF.9010409@domain.hid>
	<b647ffbd0608090235o2868571ajbe74c0b09dd27282@domain.hid>
	<b647ffbd0608090442q638115acw788da87969792cfb@domain.hid>
	<200608091709.57319.schwab@domain.hid>
	<b647ffbd0608090842w6293eb37o94f4deaeb8a7310b@domain.hid>
	<44DB778A.5050004@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Vincent Levesque <vleves@domain.hid>
Cc: xenomai@xenomai.org, andrewg@domain.hid, xenomai@xenomai.org

------=_Part_31362_27157360.1155233917610
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The patch works here too. Thanks for looking into this so quickly. I'll
> switch back to 2.1 until this is resolved.
>

It's also broken in 2.1. There are 2 problems there not releted to recently
introduced ownership-stealing part. That said, you may safely (well, you
remember this "WITHOUT ANY WARRANTY..." but indeed :) apply this patch so
far if you really need synch. message passing mechanism.


-- 
Best regards,
Dmitry Adamushko

------=_Part_31362_27157360.1155233917610
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><div><span class="gmail_quote"><br>
</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">The patch works here too. Thanks for looking into this so quickly. I'll<br>switch back to 
2.1 until this is resolved.<br></blockquote></div><br>
It's also broken in 2.1. There are 2 problems there not releted to
recently introduced ownership-stealing part. That said, you may safely
(well, you remember this &quot;<span class="gmail_quote"></span>WITHOUT ANY WARRANTY...&quot; but indeed :) apply this patch so far if you really need synch. message passing mechanism.<br>
<br clear="all"><br>-- <br>Best regards,<br>Dmitry Adamushko<br>
<br>

------=_Part_31362_27157360.1155233917610--

