References: <874kjffpa1.fsf@xenomai.org>
 <7f2c3ca2-259e-2c26-536a-67787d8430ea@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [RFC] Drop support for x86_32 from Xenomai 3.2
In-reply-to: <7f2c3ca2-259e-2c26-536a-67787d8430ea@siemens.com>
Date: Thu, 21 Jan 2021 16:33:08 +0100
Message-ID: <875z3q9uff.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org


Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 17.01.21 18:26, Philippe Gerum wrote:
>> 
>> The I-pipe and Cobalt ports to x86_32 received neither careful
>> maintenance nor testing for ages. In addition, Dovetail does not support
>> the 32bit legacy mode, and there is no plan to do so. Therefore I
>> recommend to stop supporting the x86_32 architecture starting from
>> Xenomai 3.2, which echoes what Jan has been saying for quite a while
>> about this issue too.
>> 
>> If you do care about running Xenomai on this architecture and are
>> willing to maintain such a port in the long run, this is definitely the
>> right time to make your case, asap.
>> 
>
> Just to clarify: This affects the host kernel, not 32-bit userland
> (compat), right? The latter is still a must-have in several applications
> here, and I think beyond as well.
>

Only 32bit kernel support would be dropped, 32bit compat over 64bit
would stay.

> BTW, we should also deprecate the x32 ABI.
>

Agreed.

-- 
Philippe.

