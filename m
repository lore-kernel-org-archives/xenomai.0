Subject: Re: Namespace pollution due to compiler.h in Xenomai 3.1
References: <CAFLxGvw70Rm88zfFXRqLv2_qJkd=k_C-mYxLCX0qnFwCYyGZyg@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <b5fe4180-4d04-3031-6d12-b7c9ccfa22ad@siemens.com>
Date: Fri, 13 Mar 2020 09:26:58 +0100
MIME-Version: 1.0
In-Reply-To: <CAFLxGvw70Rm88zfFXRqLv2_qJkd=k_C-mYxLCX0qnFwCYyGZyg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Richard Weinberger <richard.weinberger@gmail.com>, xenomai@xenomai.org

On 13.03.20 09:18, Richard Weinberger via Xenomai wrote:
> Hi!
> 
> Our application uses cobalt/stdio.h, which includes at the end
> boilerplate/compiler.h.
> compiler.h defines since 3.1 __packed and other gcc attribute helpers
> in the global namespace. Is this intended?
> 
> We noticed because out application also defines __packed...
> 

That's indeed bad style which I didn't realize so far. All those 
short-hands should be prefixed, e.g. like qt does (Q_NORETURN, Q_LIKELY 
etc.).

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

