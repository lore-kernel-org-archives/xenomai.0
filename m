From: =?UTF-8?Q?St=c3=a9phane_Ancelot?= <sancelot@numalliance.com>
Message-ID: <ecce0e19-a652-0945-19e3-3bbce634a374@numalliance.com>
Date: Wed, 14 Feb 2018 10:14:45 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] rt_pipe_create
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

we discovered abnormal behaviour with rt pipes.

it is sometimes impossible to write to the pipe, it returns with ENOMEM.

This mistake is dependant on the pipe poolsize allocated and the number=20
of byte size written.

Is there a minimum size to create a pipe? -- It seems that you have=20
creation problems (rt_pipe_create) when you ask for a creation with a=20
small poolsize.


Best regards,

St=C3=A9phane Ancelot




