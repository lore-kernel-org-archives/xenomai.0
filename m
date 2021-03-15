Subject: Re: Get packet timestamp in af_packet or other RTNET components
References: <4c80-604be980-9d-743e7c00@120686847>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <50033e69-b5a8-fffe-4e9e-516a947b70c4@siemens.com>
Date: Mon, 15 Mar 2021 08:16:37 +0100
MIME-Version: 1.0
In-Reply-To: <4c80-604be980-9d-743e7c00@120686847>
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
To: =?UTF-8?Q?Fran=c3=a7ois_Legal?= <francois.legal@thom.fr.eu.org>, xenomai@xenomai.org

On 12.03.21 23:21, François Legal via Xenomai wrote:
> Hello,
> 
> working on a data recorder application, I would need to get access to each packet receive timestamp (populated during packet reception ISR generally in network drivers).
> 
> I figured out, the cleanest way to do it would be using the
>  "void __user *msg_control;	/* ancillary data */" / "__kernel_size_t msg_controllen;	/* ancillary data buffer length */"
> members of the struct user_msghdr that is carried over when using the recvmsg call, plus possibly an ioctl to enable the timestamp retrieving
> 
> Did anybody already do something like this in xenomai/RTNET ?
> Any thought on the proposed vector ?
> Any chance such modification could become mainline ?
> 

I would add SO_RCVTIMEO support, like rtipc already has.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

