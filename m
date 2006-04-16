Message-ID: <4442786B.40301@domain.hid>
Date: Sun, 16 Apr 2006 19:01:31 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] let skins select nucleus features
References: <443E99C5.70202@domain.hid>
In-Reply-To: <443E99C5.70202@domain.hid>
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
> this patch aims at avoiding to select unneeded nucleus features if no
> user is requiring it in the skins. Particularly, it addresses the
> nucleus registry and the pipes.
> 
> I have spent no effort on 2.4 yet as I first want to wait for comments.
> Furthermore, 2.4. is lacking "select", so the feature selection has to
> remain manually there anyway.

Looks good. Merged, thanks.

-- 

Philippe.

