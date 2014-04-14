Message-ID: <534B89C9.4030803@xenomai.org>
Date: Mon, 14 Apr 2014 09:10:01 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <2ab33122.c8fd.1455e3347d6.Coremail.ericvic@163.com>
In-Reply-To: <2ab33122.c8fd.1455e3347d6.Coremail.ericvic@163.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] imx6q xenomai-2.6.3    ethercat master
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?5bWM5YWl5byP5bel56iL5biI?= <ericvic@163.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 04/14/2014 05:06 AM, 嵌入式工程师 wrote:
> I may have found the missing real-time problem. I use ethercat  and
> set a rt_timer to read data in 250us.Ethercat will record data once
> received cycle.We believe that  ethercat should has been read   data
> in cycles 250us  Is accurate.But with SMP enble the  delay reached
> 400us. With up-kernal it is just 30us .
> 

Please tell us what version of the I-pipe patch you are using, and post
your kernel configuration.

-- 
                                                                Gilles.

