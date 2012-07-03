MIME-Version: 1.0
In-Reply-To: <CAN_aGuVxhFh+Dd0OOd0LS9eiMj_JQj2j38peEVCMVedAxvFcfg@mail.gmail.com>
References: <CAN_aGuXSLRdWQdoJjZXqChobTe6v=qVadAmz2zq6ZLzSLRRvbA@mail.gmail.com>
	<CAN_aGuVxhFh+Dd0OOd0LS9eiMj_JQj2j38peEVCMVedAxvFcfg@mail.gmail.com>
Date: Tue, 3 Jul 2012 16:24:12 +0300
Message-ID: <CAN_aGuVDovxTMbG0CZE3eq_16jRcpZ6ZRFn-=pJ15rHYPfy5MQ@mail.gmail.com>
From: Canku Alp Calargun <cankualp@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] Igep Xenomai problem
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello All,

We are trying to develop a real time system which has a DM3730 processor on
a custom board which is similar to IGEP v2 board. We were able to run the
kernel 2.6.35 which is a xenomai patched version by igep and we were also
able to run our application on this kernel. Because of our real time
requirements, we want to use rt APIs of xenomai. The application is being
developed using Code composer Studio v5 and all related configuration for
cross compiling the system is working properly.

For reading serial data we tried to use rt_dev_read and included the header
rtdm/rtdm.h. However, We got the error "undefined reference to
`rt_dev_read". In the mailing list, it is suggested to add -lrtdm and
-llxrt as linker flags. This time compiler could not find these libraries.
Also when we search the kernel tree that IGEP provided(2.6.35-rt) we could
not see those libraries. Can you please help solving this issue or suggest
us a way?

We would really appreciate your help :)

Canku
