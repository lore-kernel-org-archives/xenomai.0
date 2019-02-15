MIME-Version: 1.0
From: Edouard Tisserant <edouard.tisserant@gmail.com>
Date: Fri, 15 Feb 2019 13:54:16 +0100
Message-ID: <CAOgDLiHxPvfY=7zUA-1nW-dP=kvbNRf_aogaFm5uuACUkKLTjw@mail.gmail.com>
Subject: Missing include/cobalt/kernel/rtdm/net.h in 3.0.8 tarball.
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

Hi

Apparently, recently added include/cobalt/kernel/rtdm/net.h is missing
in 3.0.8 tarball.

Steps to reproduce :

wget -q -O - https://gitlab.denx.de/Xenomai/xenomai/-/archive/v3.0.8/xenomai-v3.0.8.tar.gz
| tar tz | grep include/cobalt/kernel/rtdm/net.h
--> OK, file exist

wget -q -O - https://www.xenomai.org/downloads/xenomai/stable/xenomai-3.0.8.tar.bz2
| tar tj | grep include/cobalt/kernel/rtdm/net.h
--> Not OK ! File is missing

Best regards,

Edouard

