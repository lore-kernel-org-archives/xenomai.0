From: Jan Kiszka <jan.kiszka@siemens.com>
References: <0d01604d-2b7e-ea3f-e8bc-86a7f55e7d43@siemens.com>
Message-ID: <88fb67f5-04c6-b90a-c56e-dceff17284ee@siemens.com>
Date: Wed, 11 Apr 2018 15:10:06 +0200
MIME-Version: 1.0
In-Reply-To: <0d01604d-2b7e-ea3f-e8bc-86a7f55e7d43@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Locking in lib/boilerplate/hash.c
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@xenomai.org>

On 2018-04-11 13:11, Jan Kiszka wrote:
> Hi Philippe,
> 
> many users of the hash functions prefer (and actually have to) call
> those services under an external lock to close race windows, e.g.
> between lookup and entry usage. Still, those services come with their
> own, internal lock. That seems to protect only the hash list, thus
> leaves races on the entries open. I understand that some APIs (e.g.
> psos) cannot solve that easily, but I wonder if the other users should
> pay for the internal lock that is unneeded given an outer one.
> 
> IOW: How about pulling the internal lock out to the user, removing it
> from hash.c?

Also: __hash_init, which is also used for pvhash in case of !PSHARED if
I read the code correctly, does not set the mutex protocol to PI. That
could have a "surprising" impact for RT users.

I'm looking into this right now as I have a need here to switch these
locks to prio-ceiling, in order to bring down the test switching rate in
the worst case scenario.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

