Date: Mon, 01 Mar 2021 17:49:50 -0300
From: Gabriel Dinse <gabriel_dinse@hotmail.com>
Subject: Re: High latency when over stress
Message-ID: <SN6PR08MB56613104ADE0DA1381D2C581939A9@SN6PR08MB5661.namprd08.prod.outlook.com>
In-Reply-To: <e1bd5679-db02-0657-eab7-fbdd2a68f294@tj.kylinos.cn>
References: <SN6PR08MB5661F9CC518F4FDBA2B20066939B9@SN6PR08MB5661.namprd08.prod.outlook.com>
 <e1bd5679-db02-0657-eab7-fbdd2a68f294@tj.kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: song <chensong@tj.kylinos.cn>
Cc: xenomai@xenomai.org

I ran my program with trace-cmd as you said. In this case I did not=20
apply stress to the system.

Output from "trace-cmd extract" is:
CPU 0: 7790693 events lost
CPU 2: 4433 events lost
CPU 3: 4900601 events lost
CPU0 data recorded at offset=3D0x295000
    1449984 bytes in size
CPU1 data recorded at offset=3D0x3f7000
    1331200 bytes in size
CPU2 data recorded at offset=3D0x53c000
    1449984 bytes in size
CPU3 data recorded at offset=3D0x69e000
    1449984 bytes in size

Output from "trace-cmd report -l" can be seen in=20
<https://drive.google.com/file/d/1AgRPuBXIB1dFFSkQGqV9-yiTo07r6kN3/view?usp=
=3Dsharing>=20
(because it is very long)

I'm not sure how to interpret the logs.

Thank you,
Gabriel Dinse

On Mon, Mar 1, 2021 at 10:13 am, song <chensong@tj.kylinos.cn> wrote:
> trace-cmd start -e all; your periodic task
> trace-cmd stop
> trace-cmd extract
> trace-cmd report -l
>=20
> catch ftrace log to see what is going on in the system.
>=20
> Song
>=20
> On 2021/3/1 =E4=B8=8A=E5=8D=886:26, Gabriel Dinse via Xenomai wrote:
>> Hello,
>> I'm doing a comparison of interrupt handling on Xenomai using a=20
>> =7Fraspberry pi 3-b in 2 situations:
>> 1- No stress
>> 2- Running stress-ng on terminal: $ nice -19 stress-ng -c 4=20
>> --metrics =7F--timeout 120s&
>>=20
>> What I do is to create a periodic task (priority 50) that runs every=20
>> =7F500us activating gpio22 for 250us and save the activating time.=20
>> Another =7Ftask, with priority 99 is meant to catch the interrupts in=20
>> a while loop =7Fand save the time as well for computing the time=20
>> differences later. This =7Fis done 100000 times and in the end I do=20
>> some verifications.
>>=20
>> On situation 1 (no stress) I get:
>> Min: 11823ns
>> Max: 17761ns
>> Standard deviation: 258.96ns
>> Mean: 13103.17ns
>>=20
>> On situation 2 (with cpu stress)  I get:
>> Min: 12239ns
>> Max: 721302ns
>> Standard deviation: 32976.01ns
>> Mean: 29112.24ns
>>=20
>> I would not say the higher mean is actually a problem (could be),=20
>> but =7Fthe standard deviation is much higher and I don't think this is=20
>> the =7Fdesired result for Xenomai.
>> Is the first result fine?
>> What could be causing this?
>> Any addition information just ask me.
>>=20
>> Thank you,
>> Gabriel Dinse
>>=20
>>=20

