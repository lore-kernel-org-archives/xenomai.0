References: <CAMJ=MEdM7O5OBjpQV8sYyVfpToJbuy24MMfDRouDeMaryGcR+g@mail.gmail.com>
 <7bcf3d70-494c-9fa1-8554-f746ef130b7c@xenomai.org>
 <CAMJ=MEcg43Sz1aT2K3J3LMEoBhRTj8cvZqCx1a9z5y5v+XNTgg@mail.gmail.com>
 <6bc41409-f538-a50a-ee7c-a0116f4ebaff@xenomai.org>
From: Jorge Ramirez <jro@xenomai.org>
Message-ID: <dd5d5e95-30a0-8b4e-81f6-bd8b8983413e@xenomai.org>
Date: Fri, 2 Dec 2016 16:49:42 -0500
MIME-Version: 1.0
In-Reply-To: <6bc41409-f538-a50a-ee7c-a0116f4ebaff@xenomai.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai]
 =?utf-8?q?Question_about_config_option_=E2=80=93mem-poo?=
 =?utf-8?q?l-size?=
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, Ronny Meeus <ronny.meeus@gmail.com>
Cc: xenomai@xenomai.org

On 12/02/2016 01:33 PM, Philippe Gerum wrote:
> I plan to phase out TLSF entirely, which has poor performances with
> respect to memory fragmentation (the numbers are actually pretty ugly).
> So either we live with the current state of affairs until TLSF is
> replaced, or a trivial patch preventing the extension will do.

the TLSF website [1]  claims an average fragmentation lower than 15% an 
a maximum of 25%.
What do you hope the replacement algorithm will provide?

[1] http://www.gii.upv.es/tlsf/

