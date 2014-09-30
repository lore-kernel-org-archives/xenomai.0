MIME-Version: 1.0
In-Reply-To: <CANdzn7PYpjy-4h5upYf=39L-t+5dSQ0W1h6oW+UOHGJ+2=XJcg@mail.gmail.com>
References: <CANdzn7OYs4n0qjvpdKXM72cZM=AMy_1sBEVP7_P8S-56FJot3A@mail.gmail.com>
 <0d060e3cb01fa61faf28a22cf770bfd7@grandegger.com>
 <CANdzn7PYpjy-4h5upYf=39L-t+5dSQ0W1h6oW+UOHGJ+2=XJcg@mail.gmail.com>
Date: Tue, 30 Sep 2014 10:48:22 +0300
Message-ID: <CANdzn7OmiO_7T2bQN-VH=hwBAnz7TRQBtyn=hZaknB5CfxZRTw@mail.gmail.com>
From: Jason Sarantopoulos <jasonsaras@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Xenomai and CAN
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: xenomai@xenomai.org

Hi again,

I recompiled the kernel to see if I didn't configure it right in the last
time by not adding the PEAK drivers. This time when I boot to the RT kernel
I got this message before the login:
[-1.539543] Xenomai: xnitr_irq_handler: IRQ18 not handled. Disabling IRQ
line.

And when I log in, my mouse is extremely laggy and bearly moves.

I do not have much experience in RT kernels. Is this an IRQ conflict issue?

Regards.

-- 
*Jason Sarantopoulos*
