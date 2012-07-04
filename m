Date: Wed, 04 Jul 2012 14:06:15 +0200
From: Michael Wisse <mwisse@hs-harz.de>
Message-id: <e5fb2f9d1989e086.4ff44dd7@hs-harz.de>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-language: de
Content-transfer-encoding: 7BIT
Content-disposition: inline
Subject: [Xenomai] rtai emulator missing
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

I switched from xenomai 2.5.1 to 2.6.0.  We use software originally written for rtai with the rtai emulator from 2.5.1.

Now in xenomai 2.6.0 there seems to be no rtai-emulator and no rtai skin anymore. After patching the kernel 2.6.38.8  with xenomai 2.6.0 there is no kernel configuration option for rtai-emulator and I am unable to build my kernel modules, because the rtai headers are missing in xenomai. 

In which version the rtai skin was removed from xenomai and why?

Do I have to port the rtai-code to xenomai-native-api if I want to use xenomai 2.6.0?

regards 
Michael

  

  

