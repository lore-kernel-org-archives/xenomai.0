Message-ID: <4D4A8BD8.1060900@domain.hid>
Date: Thu, 03 Feb 2011 12:04:56 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTikSnhe5fnSLQm7eSOh9R7YA2cJ=m78n+S3kpW9K@mail.gmail.com>
	<4D4A84ED.7030604@domain.hid>
In-Reply-To: <4D4A84ED.7030604@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] RT OS Selection advice for parallel processing
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
> [ And, personally, I don't trust the NVIDIA driver a lot. But that might
> be influenced by the fact that latest versions lock up my notebook
> regularly after resume and that I filed another obvious locking issue of
> the compilable driver stub around mmap_sem without any response from the
> vendor. ]

Some colleague of mine is using the NVIDIA driver (through the opengl
mapping, not CUDA/VDPAU, whatever) on high-end NVIDIA boards in a non RT
situation. he definitely observed some huge latencies not due to
scheduling issues, when uploading textures to the GPU. We are talking
tens of milliseconds here.

-- 
					    Gilles.

