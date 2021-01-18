Subject: Re: [RFC] Drop support for x86_32 from Xenomai 3.2
References: <874kjffpa1.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <7f2c3ca2-259e-2c26-536a-67787d8430ea@siemens.com>
Date: Mon, 18 Jan 2021 15:07:28 +0100
MIME-Version: 1.0
In-Reply-To: <874kjffpa1.fsf@xenomai.org>
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
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

On 17.01.21 18:26, Philippe Gerum wrote:
> 
> The I-pipe and Cobalt ports to x86_32 received neither careful
> maintenance nor testing for ages. In addition, Dovetail does not support
> the 32bit legacy mode, and there is no plan to do so. Therefore I
> recommend to stop supporting the x86_32 architecture starting from
> Xenomai 3.2, which echoes what Jan has been saying for quite a while
> about this issue too.
> 
> If you do care about running Xenomai on this architecture and are
> willing to maintain such a port in the long run, this is definitely the
> right time to make your case, asap.
> 

Just to clarify: This affects the host kernel, not 32-bit userland
(compat), right? The latter is still a must-have in several applications
here, and I think beyond as well.

BTW, we should also deprecate the x32 ABI.

Jan

