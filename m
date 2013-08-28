Message-ID: <521DD779.1050103@xenomai.org>
Date: Wed, 28 Aug 2013 12:56:57 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <521DD3DD.6010300@siemens.com>
In-Reply-To: <521DD3DD.6010300@siemens.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] IPIPE_KEVT_SETAFFINITY
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On 08/28/2013 12:41 PM, Jan Kiszka wrote:
> Hi Philippe,
>
> please push to ipipe.git what introduces IPIPE_KEVT_SETAFFINITY. I'm
> riding on the tip of all trees and cannot build forge anymore. Or does
> this event rather require some feature detection in forge?
>
> Thanks,
> Jan
>

You need the top two commits of this branch, which is still the 
reference version for -forge (unlike -forge, 2.6 does not require 
KEVT_SETAFFINITY):

http://git.xenomai.org/?p=ipipe.git;a=shortlog;h=refs/heads/ipipe-3.8

These commits will land into ipipe-next when the that latter moves to 3.10.

-- 
Philippe.

