Date: Thu, 20 Jun 2013 10:29:11 +0800 (CST)
From: =?GBK?B?x7bI68q9uaSzzMqm?= <ericvic@163.com>
MIME-Version: 1.0
Message-ID: <76d212e3.f7b7.13f5f6a053b.Coremail.ericvic@163.com>
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] rel_imx_3.0.15_12.03.00  CPU Frequency Scaling
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

I'm trying to build using the instruction from Xenomai package (rel_imx_3.0.15_12.03.00) and I'm facing some issues. The kernel does not compile when I turn off 'CPU Frequency Scaling' option. I use imx5_defconfig from the standard kernel config files. When I let 'CPU Frequency Scaling' on, with Xenomai, I have the message on Xenomai configuration options, but the build run with success. Do I have to lel this option on
