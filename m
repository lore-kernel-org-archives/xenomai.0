Message-ID: <53B5A3D5.6070201@xenomai.org>
Date: Thu, 03 Jul 2014 20:41:25 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <01C12D13-C7D5-4DDD-8ED3-4359E6FBE665@mah.priv.at>
In-Reply-To: <01C12D13-C7D5-4DDD-8ED3-4359E6FBE665@mah.priv.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] arm & 64bit atomics
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Haberler <mail17@mah.priv.at>, xenomai@xenomai.org

On 07/03/2014 04:56 PM, Michael Haberler wrote:
> we found this: http://stackoverflow.com/questions/9857760/can-an-arm-interrupt-occur-in-mid-instruction and are considering which impact that has on machinekit, which uses doubles in memory shared between threads, relying on updates being atomic
> 
> I wonder if this topic has come up in the Xenomai context?
> 
> specifically - can it happen that an RT thread is rescheduled in the middle of a 64bit store?

Obviously, yes.

> 
> also, I found that for older ARM's there are kernel mode helpers to support 64bit atomics (https://www.kernel.org/doc/Documentation/arm/kernel_user_helpers.txt) - I assume those work fine with Xenomai?

Yes, the kuser helpers work, but they are more made for implementers of
a user-space run-time environment than for applications. Applications
should use the __sync_* primitives gcc proposes, and which will do the
right thing.

-- 
                                                                Gilles.

