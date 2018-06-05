References: <CAOuPNLiWw7R9j75OvFWq6RAcwgiaGaOt_4Ep0hXOz-ZOMkrrww@mail.gmail.com>
 <4e64e78c-0b25-c6e6-90cb-f48c7cdd5051@xenomai.org>
 <CAOuPNLgw8NurkqsMUK49NTKiLx1YqidQZ=i7vMMpF=Nxu1ZROg@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <9df15323-f92d-a668-ba1a-5986170996ec@xenomai.org>
Date: Tue, 5 Jun 2018 15:17:29 +0200
MIME-Version: 1.0
In-Reply-To: <CAOuPNLgw8NurkqsMUK49NTKiLx1YqidQZ=i7vMMpF=Nxu1ZROg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Applying arch specific ipipe patches - commit by
	commit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Pintu Kumar <pintu.ping@gmail.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 06/05/2018 03:04 PM, Pintu Kumar wrote:
> Dear Philippe,
> 
> Thank you so much for your reply.
> Yes, I already cloned the common ipipe.git and looked into it.
> 
> I tried to do the following:
> 1) git clone https://git.xenomai.org/ipipe.git
> 2) git checkout ipipe-4.9.y  => I think it points to 4.9.92
>     [But I need only 4.9.51]
> 
> 3) cd ipipe
> 
> 4) ./scripts/ipipe/genpatches.sh --split
> reference: v4.9.92, kernel version: 4.9.92
> fatal: ambiguous argument 'v4.9.92': unknown revision or path not in
> the working tree.
> Use '--' to separate paths from revisions, like this:
> 'git <command> [<revision>...] -- [<file>...]'
> ipipe-core-4.9.92-noarch.patch
> rm: missing operand
> Try 'rm --help' for more information.
> 
> 
> I get the above error, when I run this script.
> I am not sure what does it indicates.
> I wanted all arch patches only for kernel 4.9.51
> How to use this script to generate that?
> 
> If you have any suggestions please help!
> 

$ git fetch --tags
$ git checkout ipipe-core-4.9.51-x86-5
$ ./scripts/ipipe/genpatches.sh --split

-- 
Philippe.

