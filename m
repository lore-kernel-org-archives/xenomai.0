References: <0d01604d-2b7e-ea3f-e8bc-86a7f55e7d43@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <e46d5933-375a-c2be-f5c8-0d7a63b5162e@xenomai.org>
Date: Thu, 12 Apr 2018 11:03:52 +0200
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
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>

On 04/11/2018 01:11 PM, Jan Kiszka wrote:
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
> 

You will need to move part of the locking to the cluster abstraction,
notably in pshared mode for protecting the shared object dictionary
(main_catalog).

Also, [pv]cluster_addobj* callers generally don't implement any outer
lock, so this should be addressed too.

-- 
Philippe.

