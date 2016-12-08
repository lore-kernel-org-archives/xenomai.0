References: <50ba3868-6953-faef-5ad5-a650c0c0ea24@numalliance.com>
 <e1c90d44-be0d-91a7-98d4-e06ee0007ab1@xenomai.org>
From: =?UTF-8?Q?St=c3=a9phane_Ancelot?= <sancelot@numalliance.com>
Message-ID: <340fed26-23db-86a4-faf5-4e58c15504cd@numalliance.com>
Date: Thu, 8 Dec 2016 08:28:02 +0100
MIME-Version: 1.0
In-Reply-To: <e1c90d44-be0d-91a7-98d4-e06ee0007ab1@xenomai.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] memory allocation performance in kernel ipipe
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>



Le 07/12/2016 =E0 17:16, Philippe Gerum a =E9crit :
> On 12/07/2016 03:15 PM, St=E9phane Ancelot wrote:
>> Hi,
>>
>> I noticed very bad memory allocation performance on some of my graphic
>> programs (standard linux applications).
>>
>> If you run any classic program, you won't sea any difference, but it h=
as
>> been visible in the following context :
>>
>> I have an application that allocates thousends of graphic widgets,
>> label, input fields  at startup (a data editor) .
>>
>> Using the standard kernel, the applications starts very quickly. But
>> once the ipipe patch is applied to kernel, this application makes lot =
of
>> seconds before appearing.
>>
>> I am using a 3.18 kernel.
>>
> Is there any question?
>
Euhhh ... yes,  it sounds this problem comes from ipipe modifications,=20
But I have not managed to find the reason ???
Is it a bug , a regression , a kernel routine where the problem is=20
amplified once the patch is applied ?

I remember I have not had this problem with previous kernel releases=20
(3.16.x) . I will check again with previous configurations, in order to=20
find a way of comparison.

Regards,
S.Ancelot

