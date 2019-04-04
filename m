Subject: Re: Xenomai kernel for BBB
References: <CAFc1U0uSt1WVzeDWfzPp+07SqCD=t=ET8X+2NXieYE0WE66Xfw@mail.gmail.com>
 <4a8a6ec5-cc87-19b5-3ebe-8d0d6da6027b@xenomai.org>
 <072ec5f2-7bee-9cca-cdb6-040bb3afa59d@xenomai.org>
 <21a9ee2c-90e7-b6f3-f0cd-f57277f20a57@siemens.com>
 <CAFc1U0v=vWHK_1+R2mTEUY3AN435npqofbLb2NabP9CfvmwmFg@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <a124be63-118e-c26f-47e4-ed2f084cf9e9@xenomai.org>
Date: Thu, 4 Apr 2019 11:32:11 +0200
MIME-Version: 1.0
In-Reply-To: <CAFc1U0v=vWHK_1+R2mTEUY3AN435npqofbLb2NabP9CfvmwmFg@mail.gmail.com>
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
To: Pierre FICHEUX <pierre.ficheux@smile.fr>, Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org

On 4/4/19 11:02 AM, Pierre FICHEUX wrote:
> Thanks for your answers.
> 
> CONFIG_ARM_CPUIDLE is already unset in kernel config but I will try the
> other ways.

For reference, the typical worst-case latency with the AM335x GP EVM
(1GHz) I'm running the bbb kernel on should be lower than 50 us for
userland response time, with the average below 15 us, applying
significant stress load.

-- 
Philippe.

