From: jimmyo <jimmyo@gmx.at>
Message-ID: <6b3f6665-d424-9350-837f-cad1b3b54c7c@gmx.at>
Date: Thu, 5 Jul 2018 11:37:05 +0200
MIME-Version: 1.0
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: [Xenomai] context switch minimize
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello,

we have a running system on mx6 with Kernel 3.10.x and Xenomai 2.6.4.
i known, it's very old.
now we have to make some optmization.
In one xenomai task we need to check, if a TCP/UDP socket handle has 
data to receive.
at this time we use select to detect if there are data available and with
ioctl & FIONREAD we get count of data.

Now we must search a way, to do this in the primary domain, without 
switching to secondary domain.

Is there a way to solve it ?

we have a exists rtdm interface to a own kernel module.
And we use rt_dev_ioctl to communicate with this module.

Thanx & best regards
   Jimmy
