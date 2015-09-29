From: Johann Obermayr <johann.obermayr@sigmatek.at>
Message-ID: <560A8662.8050204@sigmatek.at>
Date: Tue, 29 Sep 2015 14:38:58 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] ipipe_read_tsc, ipipe_tsc2ns
Reply-To: johann.obermayr@sigmatek.at
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

in a loadable kernel module i use ipipe_read_tsc and ipipe_tsc2ns.
But at compiling i get follow warning.

WARNING: "__ipipe_kuser_tsc_freq" [km_testsample.ko] undefined!

we have ARM, Linux 3.0 + xenomai 2.6.2.1

Best reagards,
   Johann

