Message-ID: <52DD7375.4050602@xenomai.org>
Date: Mon, 20 Jan 2014 20:05:25 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CA+dLyOUvoZX5SeN_e2CkwQPJuv_aZ7RgC-x7gGrDwqjGNxCTkg@mail.gmail.com>
In-Reply-To: <CA+dLyOUvoZX5SeN_e2CkwQPJuv_aZ7RgC-x7gGrDwqjGNxCTkg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Asking probe method in RTDM
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Seong-hyeon Kim <zedoul@gmail.com>
Cc: xenomai@xenomai.org

On 01/20/2014 04:55 PM, Seong-hyeon Kim wrote:
> Hi,
>
>
> I am trying to call *probe* function in RTDM device driver. However, I
> could not make it, and also fail to find suitable source. It will be very
> helpful if someone let me know some good source for it.
>
>
> What I have been tried is, I use “platform_driver_register” function to
> load "platform_driver" structure as bellows:

This is not really a problem related to Xenomai, see:

http://lwn.net/Articles/448499/


-- 
					    Gilles.

