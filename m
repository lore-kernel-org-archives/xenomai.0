Date: Mon, 14 Apr 2014 11:06:30 +0800 (CST)
From: =?GBK?B?x7bI68q9uaSzzMqm?= <ericvic@163.com>
MIME-Version: 1.0
Message-ID: <2ab33122.c8fd.1455e3347d6.Coremail.ericvic@163.com>
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] imx6q xenomai-2.6.3    ethercat master
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

 I may have found the missing real-time problem. I use ethercat  and set a rt_timer to read data in 250us.Ethercat will record data once received cycle.We believe that  ethercat should has been read   data in cycles 250us  Is accurate.But with SMP enble the  delay reached 400us. With up-kernal it is just 30us . 
