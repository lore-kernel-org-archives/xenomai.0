Message-ID: <b647ffbd0608100311hea98dfeg7082e09928822d8d@domain.hid>
Date: Thu, 10 Aug 2006 12:11:50 +0200
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-core] Re: [Xenomai-help] -110 error on rt_task_send...
	bug?
In-Reply-To: <44DAED87.3040506@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_26781_28959705.1155204710049"
References: <44D7EDCF.9010409@domain.hid>
	<b647ffbd0608090235o2868571ajbe74c0b09dd27282@domain.hid>
	<b647ffbd0608090442q638115acw788da87969792cfb@domain.hid>
	<200608091709.57319.schwab@domain.hid> <44DAED87.3040506@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: andrewg@domain.hid, xenomai@xenomai.org

------=_Part_26781_28959705.1155204710049
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

if you take a look e.g. at how synch->owner is used in the current SVN
codebase then you will notice that this field is actually usefull only for
PIP objects but xnsynch_wakeup_* and friends update it for all cases. No, I
don't want to say that's why let's do the same with PENDING.

This is a preliminary patch and, that said, I'm going to take a closer look
at the synch.c.

Regarding PENDING : not sure at the moment if it would be helpful (have to
think about possible use cases), but with the help of PENDING it's possible
to support "ownership"-stealing for FOWNER objects. Sounds funny? :)

if (testbits(synch->status, XNSYNCH_FOWNER | XNSYNCH_PENDING) ==
XNSYNCH_FOWNER) {

// the object has been stolen while a thread was waiting to be scheduled on

}


-- 
Best regards,
Dmitry Adamushko

------=_Part_26781_28959705.1155204710049
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br>
Hello,<br>
<br>
if you take a look e.g. at how synch-&gt;owner is used in the current
SVN codebase then you will notice that this field is actually usefull
only for PIP objects but xnsynch_wakeup_* and friends update it for all
cases. No, I don't want to say that's why let's do the same with
PENDING.<br>
<br>
This is a preliminary patch and, that said, I'm going to take a closer look at the synch.c.<br>
<br>
Regarding PENDING : not sure at the moment if it would be helpful (have
to think about possible use cases), but with the help of PENDING it's
possible to support &quot;ownership&quot;-stealing for FOWNER objects. Sounds
funny? :) <br>
<br>
if (testbits(synch-&gt;status, XNSYNCH_FOWNER | XNSYNCH_PENDING) == XNSYNCH_FOWNER) {<br>
<br>
// the object has been stolen while a thread was waiting to be scheduled on<br>
<br>
}<br>
<br>
<br>
-- <br>Best regards,<br>Dmitry Adamushko<br>
<br>

------=_Part_26781_28959705.1155204710049--

