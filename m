From: MONTET Julien <julien.montet@reseau.eseo.fr>
Subject: Xenomai - VxWorks Emulator - Implementation of taskWait()
Date: Fri, 28 May 2021 07:40:14 +0000
Message-ID: <PR3PR02MB6202889054902C3CC902EF15D1229@PR3PR02MB6202.eurprd02.prod.outlook.com>
Content-Language: fr-FR
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hi the developers,

I already succeeded to use Xenomai with API/libraires such as Alchemy and P=
osix.
My goal is now to use the VxWorks API.
I don't have any issue to include path/librairies but I am trying to use th=
e function "taskWait" (used by VxWorks) that is not present in Xenomai-VxWo=
rks.
https://docs.windriver.com/fr-FR/bundle/vxworks_7_application_core_os_sr063=
0-enus/page/CORE/taskLib.html#taskWait
https://xenomai.org/documentation/xenomai-3/html/xeno3prm/include_2vxworks_=
2taskLib_8h_source.html

I don't really know if this function is obvious or if a similar code could =
run on Xenomai.
Could you advise a way to implement something that looks like taskWait ?
Could rt_task_wait_period<https://xenomai.org/documentation/xenomai-3/html/=
xeno3prm/group__alchemy__task.html#ga1645d3a072ef3cefeed3bcbb27dcf108> from=
 Alchemy (task.h) be an interesting solution ?

Regards,

Julien

