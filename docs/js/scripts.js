// document.addEventListener('DOMContentLoaded', () => {
//   document.querySelectorAll('.emoji-input').forEach((input) => {
//     input.addEventListener('change', () => {
//       const currentForm = input.closest('.teacher-rating')
//
//       currentForm.querySelectorAll('.emoji-label').forEach((label) => {
//         // Define a opacidade de todos os emojis para mais clara
//         label.style.opacity = '0.5'
//       })
//
//       // Ajuste aqui: encontra o label correspondente ao input selecionado
//       const selectedLabel = input.labels[0];
//       if (selectedLabel) {
//         selectedLabel.style.opacity = '1';
//       }
//     })
//   })
// })
//

document.addEventListener('DOMContentLoaded', () => {

	document.querySelectorAll('.emoji-label').forEach((label) => {
			label.style.opacity = '0.5';
		});

	document.querySelectorAll('.emoji-input').forEach((input) => {
		input.addEventListener('change', () => {
			const currentForm = input.closest('.teacher-rating');

			currentForm.querySelectorAll('.emoji-label').forEach((label) => {
				label.style.opacity = '0.5';
			});

			const selectedLabel = input.labels[0];
			if (selectedLabel) {
				selectedLabel.style.opacity = '1';
			}
		});
	})
})
