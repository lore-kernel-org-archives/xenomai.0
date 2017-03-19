References: <07fe7fa20faed6e818d33b54db9001b6@stupar.com>
 <adbf2787-6a0e-588e-272e-be15686fc2b7@xenomai.org>
 <ee4b936505fe83420d3e95303ebe6058@stupar.com>
 <ddc23472-e188-5482-be39-dc8f8917eed6@stupar.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <305872a6-028d-64e3-4804-9c46e7407193@xenomai.org>
Date: Sun, 19 Mar 2017 10:51:12 +0100
MIME-Version: 1.0
In-Reply-To: <ddc23472-e188-5482-be39-dc8f8917eed6@stupar.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] RTDM driver init: interrupts and context objects
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Andrija Stupar <andrija@stupar.com>, xenomai@xenomai.org

On 03/18/2017 05:28 PM, Andrija Stupar wrote:
> Well, I can answer my own question from a couple of weeks ago. Nothing
> was wrong with the way the RTDM interrupts were coded - the port from
> Linux to RTDM was done properly. The problem was a mode switch, falling
> into secondary (non-RT) mode. As I gather from the Xenomai RTDM API
> documentation, rtdm_event_wait(...) can only be called in RT mode. That
> is, if you call it non-RT mode it does nothing. When this call is made
> in non-RT mode, it just falls through (i.e. it does nothing).

Actually, it does something wrong. You should always enable
CONFIG_XENO_DEBUG_COBALT to detect those spurious call sites.

-- 
Philippe.

