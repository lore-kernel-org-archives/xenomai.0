Message-ID: <435D44D0.7000305@domain.hid>
Date: Mon, 24 Oct 2005 22:32:16 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH: 0/3] powerpc merge
References: <435CA008.6060109@domain.hid>
In-Reply-To: <435CA008.6060109@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: Heikki Lindholm <holindho@domain.hid>
Cc: xenomai@xenomai.org

Heikki Lindholm wrote:
> Merge 32- and 64-bit powerpc architectures into a common powerpc arch in 
> anticipation of the similar merge happening in linux kernel (possible in 
> 2.6.15). Amount of shared code between 32- and 64-bit ppc is substantial 
> and I don't see anything changing that. These patches will simplify 
> maintenance. In case the mailing list rejects the largish attachments 
> I'll see if I can use the patch tracker in gna instead.
>

Ok, thanks (patches made their way). Will merge in the next-to-come 2.1 branch 
that should appear this WE. I have made progress separating the kernel and 
user-space supports, and compiling the whole Xenomai modules inside the kernel, 
so basically we just need to wait for the user-space support to be compilable 
anew for the branch to appear.

-- 

Philippe.

