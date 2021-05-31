Subject: Re: Installing Xenomai 3.1 but some references to 2.99 appear
References: <CAB9YM8i9Wzj_YNH869mznfnVMzPJ0G9Qpod4aipWKxFFkatXBg@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <b4b6a67e-69e9-b459-41f4-d4e0ecd7d3f4@siemens.com>
Date: Mon, 31 May 2021 10:28:28 +0200
MIME-Version: 1.0
In-Reply-To: <CAB9YM8i9Wzj_YNH869mznfnVMzPJ0G9Qpod4aipWKxFFkatXBg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?Q?Jo=c3=a3o_Costa?= <joaocostalapin@gmail.com>, xenomai@xenomai.org

On 27.05.21 16:33, João Costa via Xenomai wrote:
> Not sure if it is supposed to be like but while installing Xenomai 3.11 I
> get some outputs mentioning Xenomai 2.99.0
> 
> (I am following this instructions [1] )
> After running
> *$debuild -us -uc *
> some messages and the output files refer to xenomai_2.99.0
> 
> 
> [1] https://www.programmersought.com/article/14375437246/
> 

This is due to stale debian/changelog. Should probably be updated.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

