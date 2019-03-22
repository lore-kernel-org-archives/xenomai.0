Subject: Re: Still More Slackspot Issues - Patch Included
References: <20190321171330.2073-1-rpm@xenomai.org>
 <20190321171330.2073-17-rpm@xenomai.org>
 <CAO460_-FMijvbCcBm_pepCswo_xfAmCjiBPtq213M4Gg7C6S2A@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <8ec90064-d5c5-d165-1165-b080182aa022@xenomai.org>
Date: Fri, 22 Mar 2019 16:51:30 +0100
MIME-Version: 1.0
In-Reply-To: <CAO460_-FMijvbCcBm_pepCswo_xfAmCjiBPtq213M4Gg7C6S2A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Stephen D. Cohen" <steve@uscohens.com>, xenomai@xenomai.org

On 3/22/19 12:31 AM, Stephen D. Cohen via Xenomai wrote:
> Folks,
> 
>      Some time back I submitted a patch for the slackspot issue
> regarding when to remove the vm_start offset from the program counter
> in the relax handling mechanism in debug.c. My solution had the
> unfortunate flaw that it peeked into the actual ELF section headers in
> the running system (ewww...) and was deemed unworthy. The solution
> that got implemented, using VM_DENYWRITE to detect dynamic objects,
> has the unfortunate flaw of not working with position independent
> executable programs. The very problem that got me started in the first
> place.
> 
>      As luck would have it, I recently needed slackspot to figure out
> some issues with our application. So I set out to make it work again.
> In the process, I also found another issue - when the target
> application uses inline routines, all the spots in the same file past
> the inlined routine are reported incorrectly. This is due to slackspot
> assuming a 1:1 mapping between addresses and reported results. The
> inlined routines actually report two sets of results for each address.
> 
>      So I propose the attached solution. Move the trouble of
> identifying the ELF object type out of the kernel and put it in
> slackspot instead. Just store both the pc and vm_start for every spot,
> then figure it all out in slackspot. Slackspot then uses elfread to
> determine if the file is a dynamic object or not (if it is EXEC, it is
> not dynamic, otherwise it needs to have vm_start taken off). I also
> fixed the inline issue.

Ack, moving the symbol resolution to user-space just makes sense.

-- 
Philippe.

