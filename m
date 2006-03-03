Message-ID: <4408C306.3000109@domain.hid>
Date: Fri, 03 Mar 2006 23:28:22 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] XENO_ASSERT limitation
References: <44088DE2.6090100@domain.hid>
In-Reply-To: <44088DE2.6090100@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Hi,
> 
> I noticed and appreciated the new XENO_ASSERT macro. But when looking at
> it more closely, I wondered how to express actions like this:
> 
> 	bail_out("something is broken");
> 	return -ENOTGOOD;
> 

Ok, albeit I very much dislike macros that could cause weird control flow issues, 
I must admit that limiting the action field in the generic assertion helper would 
be rather arbitrary. The new version avoids this. Thanks.

> The "action" parameter is only considering printing. Why not leaving
> this part completely in user's hand?
> (sorry, no Xenomai checkout at hand, thus no patch)
> 
> Jan
> 
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


-- 

Philippe.

