Message-ID: <4587E99D.9070404@domain.hid>
Date: Tue, 19 Dec 2006 14:31:09 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4582E67C.70108@domain.hid>
In-Reply-To: <4582E67C.70108@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] Re: [RFC] git workflow
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main <adeos-main@gna.org>

Jan Kiszka wrote:
> ...
> [Keeping up-to-date]
>  1. The original kernel tree may have been updated, and the ipipe patch
>     needs to be rebased
> 
>     # git fetch
>     # git rebase origin

I meanwhile learned that rebasing doesn't work well with public git
tree. Once you pushed some tree, say, linux-2.6.19 + ipipe-patch1..n
out, you cannot rebase to 2.6.20 + ipipe-patch1..n without breaking the
linear history.

Either we only push out final trees (but that would lock-out early
testers that may want to pull from devel-head), or we need to evolve
with ipipe patches deeply merged. That means when we have 2.6.19 + ipipe
cleanly on top of it, pulling 2.6.20 origin may cause conflicts (like
the paravirt stuff does on i386 ATM). We would then have to merge the
upstream patches into the I-pipe tree, effectively adopting them to
I-pipe. An extraction of a potential I-pipe patch stack would be more
complicated that way, but not infeasible.

Comments?

Jan

