From: Steven Seeger <steven.seeger@flightsystems.net>
Subject: Re: [PATCH] powerpc: ipipe: Do full exit checks after
 __ipipe_call_mayday
Date: Thu, 19 Dec 2019 12:01:53 -0500
Message-ID: <1738468.DV2hKNJMbQ@omoikane>
In-Reply-To: <fd31a72f-ac46-034b-bfc6-4e125b4fde78@siemens.com>
References: <d93a6092-b340-b74b-ff3d-51ac5c438c25@siemens.com>
 <fd31a72f-ac46-034b-bfc6-4e125b4fde78@siemens.com>
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

On Thursday, December 19, 2019 11:53:36 AM EST Jan Kiszka wrote:
> > Ho, ho, this is an early X-mas gift.

Thanks for finding this. I'm a terrible PPC maintainer so if anyone else wants 
to volunteer to take my place.... ;)
 
> Looking at DoSyscall in entry_32.S, it seems we lack such a careful
> check there as well. But that's too much assembly for me ATM.

Thanks for the tip I should be able to look into this tomorrow for you. Can 
you point me to the relevant sections in arm that I should compare to? 

Any more details (such as desired check/operation) you can provide would be 
beneficial.

Steven




