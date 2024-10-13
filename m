Received: from sonic312-26.consmr.mail.ir2.yahoo.com (sonic312-26.consmr.mail.ir2.yahoo.com [77.238.178.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5BC7E574
	for <xenomai@lists.linux.dev>; Sun, 13 Oct 2024 20:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.238.178.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728849756; cv=none; b=kQ2oMVk+c01H/pxkNfJ8QpeJh8sDx0di/o8setA9qa+gkuvkWyPZ/O6njizjWHb4sDUNHMeYng/nVXg+K7xRCxOwwkZp9lNKZspwkHMYkoXV7sGNC5gf+DtgLsjnoWHJ9S1stb/U/VkqA2YP4ftTZzb3R1IliRl96xehnlXJ5zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728849756; c=relaxed/simple;
	bh=18UBxwfPNUoOKlq2l7JoN9+hzM/nk5NYtGMhBzejvXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NHynTgRear+z7A0cNDMEqYkH4OB5MjvTLWPlVGdTxQOeR5lACim7lGxp9nShoDBfVASvs13tMYv4f+xadAnfviH/620sgfc0Sk78lBFqObQToP1QeLzfzQzVTBLW8pwryEik4PhaimMyvgWSeYZR2WWyyOhLIks3sZ2JX5rZ9yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=OQ3Ym6Gc; arc=none smtp.client-ip=77.238.178.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="OQ3Ym6Gc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1728849746; bh=gm5uIuAMysPtMe4DCKXfBMdQBv84X6+fstx5NbDyd4w=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=OQ3Ym6GcOAq00f2MindVP5XR+TZ3B1Pl7+hT9RMP5f85CpS89nYdLLmzuQxzX9HgjXC8jrwm/fhWSgqRgsb/zRAeAg5hR4vOzqQcn/ewZbhROf41V59E/noegmsGe9Jci8FlVPv255yddb/vdf9+fCnENRAanwvWT1V34FfzaT7oLEUqxvYq5P6UFtZgsbmmDimpgVvsSP12tHPCGsC8JagDNo6vxLqQt4JFvaphIzeauouCFra0PU8vTG7XfoKIppnuYOjZYgAMcg/aglQaxfxRzJnY8llMuQrqf5Dse+6bmHbYb2gr3WBUKGkC1WwyBSyroDpqe+WlzpfqBqpnDg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1728849746; bh=VmuFKon+1WV9I4n7iLlUEzz/rKsjKMZrXB/lYFl9/Q2=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=DpGxzp77BKJRKzChUI/gEvGU/SS8oS9zC64EQBiERQr4ROBlIldcNjlnWrJDk5kstHKmtdzY636CkSBnzo7n+YQI6Rv9kcTY+Egf8acAyFg/MhTFOw54/dP16c7myHNJ915GiaRmbgeNnUWVykeMyGEeYrJ4rsB0S0i5jYurOyKCP7CjBsJ/i/WmUCt6Ug8aq3323TcQ95wbcVJApRsGslliBes/VxsW+zsLmNcPnfseWQ8h/SK7PRYF/VGbKzrNjVM0I4kALBcqtq4Y7UKtD3HND8xnhFjOKKiKhS/OA9D2OntCIqU0HevBkx93HhmigQ6iqmengrk36BPWjTwuKg==
X-YMail-OSG: 3mvz9IAVM1lITQ84UDf4uios1lypWMyUTLgn_Pe0JdjYOuHrXi67inwCRCuNr23
 QD1_5fZ1BWafcSohz9e6B0xQbVm6Sojjbi5uF_TU_r5nY6BZyifggy6ygbuF5o7j4tyriCOGlfsS
 ecSck_pSDWhDo0S23R7zZTHn_eAFH0nXaKf3iNIUB6cIypt7G74kglDD.pFcrP7u4UQI6TyLGkSw
 Faru9OCSllir0IZP18hwRxFTLYgQjAyGStZw0GMedqRdBePIPOhbNIZ8vBtNb.szIl452h4cEkEc
 eMQd9rNkbHAsz.qmaes1oEX7iCYeqvoocCsSppEOym3Sug9FLOrt6NDUbsrr1oyQWe3q3ZuBmCAM
 3y8wRpKDMoF4da3ROR0RDFjHN5TQ0hrVoSujAHKKeHfFkWpkrQVTCfxnTA2N5up2nJaKFVGxy6Ho
 RiQGlsPMsxBfVlJWqn83xOdgh85bzK_qTFPfApiNNvQG7MguwFwuN_jhLpQwy9JoMvqYhswrZISE
 Yj3d69t0xQ7TfwJntN5XjqZf3j7iYiXDrNqFqgsSc7aTZVTKEx7oi8ysJ9MOucCY2HuT_05nsm7S
 JRmwrbDqSBoRarD80d5unJ672Rs4DBxAFPt7KEVha7FJ2VCKZroPCm2zilBurvXa65UnpjkiJnNE
 q9XKOaQ4yl6VaQNiz5zpo4jKvsIotU58rQQ7NF0J0UnVTdq69CPEvRMB9blpT7Ket_6kFqAFosCa
 1Rvif_5eIBCa3EaRTHNVI2t12hUqpJ890LUy.rcF9TOfppsOWVD_nnikD10QAVneTu3OEpVqYsO8
 MWvIgjHBOt1qVmmPMrVOB1ARUkAQF3PVCUhhhLZEHIhdHfHI1Okd039CT0D_hU1JJb93q.gdevMG
 mOazsc2947KS68ail53zpIfEV7yCjeQfjTVaJsmvKoqNhP7bOzb1niy049ahdd2KeKwXBceHR0wz
 Bzd99RfEnlEK8AeaTxsvJF0Q5YuVhoYuwncppTYHy0W9xnoPgJgvQBe91lGjGSq.kPaZ65R_uxn3
 qq7UniTpN4CsbZsHVl4HyfE6xNsi2tzPD0zy9vnmrlAc_ydFKPNx9wZVIiovbjytWTApPN8GtfbR
 3pBWXu6an_jPNN2Pka9SaaTQHs5TbgTMGAt9EhXwSGmdvzO8F_QYHr7bvGU.INjLzwPbX80TKv2n
 amV_ZzBFFXiI4fZjmKXE4NU8TZA1GvP0OdA45jUmcMFfJAsbdHSrp.DkWGzYIpqnU7xRGdmaJudd
 cIYgMve04SrLv3B8frYD6_cPTLB6oy6OBlMbUFQXdoM6wVGHiDKDm.Q8rgwZl9504REFb1X2YF9q
 WF2ZVBAR2LK9V5GRVuNEY0xTNMVjCpyNPdyucoAjWX_SUNuox1J3vutyg3ckuDMTDY5jzMjnUe3J
 VGskf44xqD3C0D43H6faeo6P_n80.2iYPOy63WrRDQ9vN0QsBHlnXPQlMLXRH.KFKoLGCf9v0h1V
 sLcd9dPoXycFljkCO3qyldhcvFbMynZFlcQduw4UtW2ZbQ_ws_ch__lwtFs1zYRyMn7e57sWHe8T
 CsWdd.1BtF8sXKlL77srNcfjwjTaPQ.1Lga3Ntd3mg_0AGaAV0lefEJGEZ6qFR2G.unUiZ4zGn3s
 MrFYYWA_X_SjplQ.T0pZkvEavhnqMgqGj0s4plZGxoSF.aAf7Y9CgxMAZAeYyn98_P8vxUdN3qPL
 JIeNW8SF3HDDoDwCeKURQPwl6khTwVKC1uYzc8Af8y_6RD_cWDPs4fGE7yUsFY__.of90CGsIqg6
 lA9OXpEIzgNbVzuVSY2KhhntqVGl_j_n3TcHm99hpufyPMd.r0cic_1ozfVW_aTmLWc4ekAJNsHk
 Wzu8.tTHtKGBidB2nqHPalfwJm6jOkeQLP4yiI6_0wIL3QkQt2Rq3p73JhtnflRn42.XCNqjooIc
 MkcjDrTeSN8.dvyMix0KyC.IZKwahyyvPRvUHYvsGxhLUQSVQQb2KTsBRUPaz61YlEByXQElrRPO
 9dsngVShwfLDhuo8gkR2c10E8suZGW1yehDJqq2U6P_Bw4isaOwmhcm9sO1t2YVOJuD1OhF7_o9I
 FndHJLSD0BPXrVALp7FWCIntojcJDYn6q5wFRjSHAWnitw6Pk2zBDB1iSEhbREuHFkHa8RIT5FRc
 xEhztm4s1n9k_ls.P_mdzK9C_NwzZ9Ef4r.pjKmrgFcKCBxji3k_3kUKqQSEj_fdmKsAhuVYFwdG
 L0obOR4rMGVX1sqleIZpmK4jM
X-Sonic-MF: <mau.salvi@yahoo.com>
X-Sonic-ID: fec43500-99dc-49b6-9a70-47eeecf973c1
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ir2.yahoo.com with HTTP; Sun, 13 Oct 2024 20:02:26 +0000
Received: by hermes--production-ir2-6664f499fc-6rh2p (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 6357e67f6a6a6cce32e495ef399ddf10;
          Sun, 13 Oct 2024 20:02:21 +0000 (UTC)
Message-ID: <f4fb9ee0-9231-4bc7-8a10-6714f7838042@yahoo.com>
Date: Sun, 13 Oct 2024 22:02:19 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lib/cobalt/internal: Fix lock-ups of cobalt_monitor_wait
 over signals
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@lists.linux.dev>
References: <d1064925-b480-458f-b88d-a2f932d34db2@siemens.com>
Content-Language: en-US, it
From: "Mauro S." <mau.salvi@yahoo.com>
In-Reply-To: <d1064925-b480-458f-b88d-a2f932d34db2@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22806 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 11/10/24 16:57, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> This is a very long pending issue, actually since day #1 of this code.
> We were checking the wrong return code for interruptions by Linux
> signals. Rather than using the opret code that the cobalt_monitor_wait
> syscalls set when the xnsynch_sleep_on was interrupted, we checked the
> syscall return code that might have been set to -EINTR as well in case
> prepare_for_signal found a pending signal while returning to userspace.
> However, in that case the monitor was still entered, and our attempt to
> enter it again from userspace caused a deadlock.
> 
> This was first reported in [1] over alchemy's rt_buffer_read, but it
> could affect many more direct or indirect users of cobalt_monitor_wait
> & Co.
> 
> [1] https://lore.kernel.org/xenomai/9d5bb262-0646-451e-a5af-82c0473a3003@yahoo.com/
> 
> Reported-by: Mauro Salvini <mau.salvi@yahoo.com>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
> 
> It took a few hours to understand and fix, but 11 months to finally
> reproduce locally. Anyway, the bug was 13 years old, so... :)
> 
> Mauro, in the end it was just a main thread handling a signal (not even
> terminating) over timing-out rt_buffer_read. As the race window was
> small in the kernel, I added there an udelay once I thought I understood
> it, and it triggered on any setup withing a minute or less.

Great catch Jan!
Thank you!

> 
>   lib/cobalt/internal.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/cobalt/internal.c b/lib/cobalt/internal.c
> index d721e7ec69..dd3da08558 100644
> --- a/lib/cobalt/internal.c
> +++ b/lib/cobalt/internal.c
> @@ -269,7 +269,7 @@ int cobalt_monitor_wait(cobalt_monitor_t *mon, int event,
>   	 * we need to redo. In the meantime, any pending linux signal
>   	 * has been processed.
>   	 */
> -	if (ret == -EINTR)
> +	if (opret == -EINTR)
>   		ret = cobalt_monitor_enter(mon);
>   
>   	return ret ?: opret;
-- 
Mauro S.

