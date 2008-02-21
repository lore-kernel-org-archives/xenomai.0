Message-ID: <2ff1a98a0802210750m56cb5c96ue56028c1893cfa6@domain.hid>
Date: Thu, 21 Feb 2008 16:50:54 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <47BD9C23.6000705@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <47BD9C23.6000705@domain.hid>
Subject: Re: [Xenomai-core] [PATCH] Fix POSIX skin build for 2.4.x
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
Cc: Xenomai-core@domain.hid

On Thu, Feb 21, 2008 at 4:43 PM, Jan Kiszka <jan.kiszka@domain.hid> wrote:
> Hi Gilles,
>
>  the backport from trunk was borken. This patch makes 2.4.x build again,
>  but - BIG-FAT-WARNING - I haven't tested the result.

I was almost sure I added the additional argument to
xn_copy_from/to_user. It appears I did not. Anyway, I will apply your
patch, thanks.

-- 
 Gilles Chanteperdrix

