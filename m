From: Steven Seeger <steven.seeger@flightsystems.net>
Subject: Re: [PATCH] powerpc: ipipe: Do full exit checks after
 __ipipe_call_mayday
Date: Thu, 19 Dec 2019 12:15:36 -0500
Message-ID: <15932776.13ek4xDJqg@omoikane>
In-Reply-To: <d09d638e-276b-9a4d-28e9-e58392bb6aeb@siemens.com>
References: <d93a6092-b340-b74b-ff3d-51ac5c438c25@siemens.com>
 <1738468.DV2hKNJMbQ@omoikane>
 <d09d638e-276b-9a4d-28e9-e58392bb6aeb@siemens.com>
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>, Philippe Gerum <rpm@xenomai.org>

On Thursday, December 19, 2019 12:14:27 PM EST Jan Kiszka wrote:
> 
> Check ipipe-arm/ipipe/master:arch/arm/kernel/entry-common.S for the call
> to ipipe_call_mayday. I suspect that pattern transfers nicely.
> 
> Jan

Will do. Can you point me to a smokey test that will prove the implemention is 
fixed? Preferably if you have something that shows it's currently broken.

Steven




