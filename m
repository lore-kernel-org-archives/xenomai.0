Subject: =?utf-8?q?Re=3A_rt=5Ftask=5Funblock=28=29_POSIX_alternative?=
Date: Tue, 14 Apr 2020 12:39:50 +0200
From: =?utf-8?q?Petr_=c4=8cervenka?= <grugh@centrum.cz>
References: <20200407154117.5D7D71C2@centrum.cz>,
 <b9ce43ab-526d-71b8-c761-150dc7c1fd3f@siemens.com>,
 <20200407171816.E0B3979D@centrum.cz>,
 <CAFLxGvx2EhOgUnB1VkW+7TendLUcsZ0XGGcwYhiPw7PcxwFkTw@mail.gmail.com>,
 <20200408114406.6119E0D9@centrum.cz>,
 <CAFLxGvx9-awne2He+ULqOzwf0cGae1s_k+-b8tdiM+uT67+cYg@mail.gmail.com>,
 <20200409170009.5B0DAA77@centrum.cz>,
 <CAFLxGvy8SP+4mr3PYYRHuxww=22w28RjaDPUgDSVFVHx-_cQ_g@mail.gmail.com>,
 <20200409201057.74CB5ED0@centrum.cz>,
 <CAFLxGvxuZw57FvaAQEAxseamoPhHdKX7wfZoaZxKskgeXa4V9g@mail.gmail.com>,
 <20200414101600.F9AA555D@centrum.cz>,
 <CAFLxGvz7ewnVv57QiEfCG76tjGcJ5v9KSg0QNHwtMa0Hihp_dQ@mail.gmail.com>,
 <20200414111059.39716137@centrum.cz>,
 <CAFLxGvx4qs8ONbaiU37rFNqXy=n8Hat_p-V7fLAAxgskbuU_GA@mail.gmail.com>
 <6b8c89d1-bae0-90f5-4935-925fb0af2137@siemens.com>
In-Reply-To: <6b8c89d1-bae0-90f5-4935-925fb0af2137@siemens.com>
MIME-Version: 1.0
Message-Id: <20200414123950.7969BF83@centrum.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?utf-8?q?Jan_Kiszka?= <jan.kiszka@siemens.com>, =?utf-8?q?Richard_Weinberger?= <richard.weinberger@gmail.com>
Cc: Xenomai <xenomai@xenomai.org>

>=C2=A0 =C2=A0 err =3D __STD(pthread_kill)(task, SIGUSR1);
>=C2=A0 =C2=A0 if (err !=3D 0) {
> =C2=A0 =C2=A0 =C2=A0=C2=A0 printf("pthread_kill failed: %d (%s)\n", err, =
strerror(-err));
>=C2=A0 =C2=A0 }

 Thank you Jan. This is what I needed. You have alredy mentioned it in the =
past. But I just used the pthread_kill() and somehow totally missed the __S=
TD() thing.
Petr

