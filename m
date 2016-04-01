MIME-Version: 1.0
Date: Fri, 1 Apr 2016 18:17:38 +0200
Message-ID: <CABprWp=4Ph8wRqtXnB7AocU0MkaYax+qC0UHRkaoFt8uhnk=vg@mail.gmail.com>
From: Varun Deshpande <varun9485@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] Request for support of SIOCSHWTSTAMP
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello Folks,

As Xenomai-RTnet has combined, it is the solution for many hard realtime
systems but the main feature which is missing is SIOCSHWTSTAMP.
As i210 supports harware timestamping, it is crucial for performance
analysis. But it is not supported by rt_igb driver as SIOCSHWTSTAMP returns
"OPERATION NOT SUPPORTED"

I kindly request you guys to please incorporate this feature so that user
can get hardware timestamp in cmsg header by enabling SIOCSHWTSTAMP option
for rt_igb driver as many of the ptp, avb programs evaluation is done by
hardware timestamp only.

Best Regards

Varun Deshpande
Exchange Program Student,
ESIEE Paris
+33 760 349 859

Alma Mater
Electronics & Communication Engineering,
National Institute of Technology, Bhopal (INDIA)
+91 8965 080 507
