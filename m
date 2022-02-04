From: "Kristian Rahbek" <kri.rahbek@gmail.com>
Subject: Can mode switches of one thread effect realtime of other xenomai
 threads?
Date: Fri, 4 Feb 2022 11:51:42 +0100
Message-ID: <001a01d819b5$32589230$9709b690$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-dk
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

We are running Xenomai 3 with Cobalt kernel.
We have a realtime xenomai userspace application (which is driven by a =
RTDM), it runs with the highest priority and doesn't have any mode =
switches. Let's call it thread 'A'.
Reading the documentation it's unclear to us, if it can have any =
ill-effects on the realtime performance of thread A, if the process =
which spawns thread A has other Xenomai threads, which do have mode =
switches.
Is that the case?
What about separate processes with Xenomai threads, if those have =
switches between primary and secondary mode (MSW's), can that have any =
effect on the realtime performance of thread A?

Best regards,
Kristian Rahbek


