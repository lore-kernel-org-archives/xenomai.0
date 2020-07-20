Message-ID: <trinity-a5d2dc06-bdcf-4614-ad99-60c9ba7451fa-1595221515686@3c-app-gmx-bap35>
From: Jan Holtz <jan5697@gmx.net>
Subject: malloc and stl container
Date: Mon, 20 Jul 2020 07:05:15 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
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
   i am using xenomai 3.0 on a cobalt x64 smp system with the alchemy
   skin.
   As far i know dynamic memory allocation can cause a context switch,
   which should be preventet.
   If i am right,malloc should not cause a CSW anymore at this xenomai
   version.
   If malloc don't cause a CSW,  in which case the alchemy heap management
   services is suggested to use instead for dynamic memory allocation?
   I like to use stl containers like vector, etc.
   Is there a way to use this containers wthout adding values to
   containers seems to cause a CSW.
   Can it work/wrapped with heap management services ?
   Hope you can help me to understand.
   Regards Jan
